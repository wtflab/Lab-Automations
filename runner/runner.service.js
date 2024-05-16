import { writeFile, unlink, rm, readdir } from "node:fs/promises";
import { Utils } from "./utils.js";
import AdmZip from "adm-zip";
import path from "node:path";

export class RunnerService {
  static async runTests(files) {
    const taskFilePath = "task.dart";
    const testFilePath = "test.dart";

    const command = `make test`;
    const failedTests = [];

    for (const file of files) {
      await writeFile(taskFilePath, file.taskFile, "utf-8");
      await writeFile(testFilePath, file.testFile, "utf-8");

      try {
        await Utils.execAsync(command);
        console.log(`File ${file.fileName} passed tests successfully`);
      } catch ({ stdout }) {
        const failedTest = {
          fileName: file.fileName,
          input: "",
          expected: "",
          actual: "",
          isFatal: false,
        };

        const isFatal = stdout.includes("Failed to load");
        if (isFatal) {
          failedTest.isFatal = isFatal;
          console.log(`Failed to load ${file.fileName}`);
        } else {
          const testInfo = Utils.parseTestInfo(stdout);
          failedTest.input = testInfo[0] || "";
          failedTest.expected = testInfo[1] || "";
          failedTest.actual = testInfo[2] || "";

          console.log(
            `File ${file.fileName} didn't pass test. Input: "${failedTest.input}" Expected: "${failedTest.expected}" Actual: "${failedTest.actual}"`
          );
        }

        failedTests.push(failedTest);
      }
    }

    await unlink(taskFilePath);
    await unlink(testFilePath);

    return failedTests;
  }

  static async runFormatter(archive) {
    const appPath = "app";
    const zip = new AdmZip(Buffer.from(archive));
    zip.extractAllTo(appPath, true);

    const command = `make format`;
    const formatterFailedFiles = [];

    const { stdout } = await Utils.execAsync(command);
    const filePaths = Utils.parseFormattedFilePaths(stdout);

    for (const filePath of filePaths) {
      formatterFailedFiles.push({
        path: filePath,
        fileName: path.basename(filePath),
      });
    }

    if (!formatterFailedFiles.length) {
      console.log("Formatter passed");
    } else {
      console.log("Formatter failed");
    }

    await rm(appPath, { recursive: true });

    return formatterFailedFiles;
  }

  static async runLinter(archive, sessionType) {
    const appPath = "app";
    const zip = new AdmZip(Buffer.from(archive));
    zip.extractAllTo(appPath, true);

    const linterOptions = await Utils.getLinterOptions(sessionType);
    const appPathContent = await readdir(appPath);
    const zipName = appPathContent[0];

    await writeFile(
      path.resolve(appPath, zipName, "analysis_options.yaml"),
      linterOptions
    );

    const command = `make lint`;
    let linterFailedFiles = [];

    try {
      await Utils.execAsync(command);
      console.log("Linter passed");
    } catch ({ stdout, stderr }) {
      const failedFiles = Utils.parseLinterFailedFiles(stdout);
      linterFailedFiles = failedFiles;
      console.log("Linter failed");
    }

    await rm(appPath, { recursive: true });

    return linterFailedFiles;
  }
}
