import { writeFile, unlink, rm } from "node:fs/promises";
import { Utils } from "./utils.js";
import AdmZip from "adm-zip";

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
          failedTest.input = testInfo[0];
          failedTest.expected = testInfo[1];
          failedTest.actual = testInfo[2];

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
    console.log("start");
    const appPath = "app";
    const zip = new AdmZip(Buffer.from(archive));
    zip.extractAllTo(appPath, true);

    const command = `make format`;
    const formatterResults = [];

    const { stdout } = await Utils.execAsync(command);

    // for (const file of files) {
    //   let res = {
    //     fileName: file.fileName,
    //     success: true,
    //   };

    //   await writeFile(taskFilePath, file.taskFile, "utf-8");

    //   const { stdout } = await Utils.execAsync(command);
    //   const changedLines = Utils.parseChangedCount(stdout);
    //   if (changedLines > 0) {
    //     res.success = false;
    //     console.log(`File ${file.fileName} failed formatter`);
    //   } else {
    //     console.log(`File ${file.fileName} passed formatter successfully`);
    //   }

    //   formatterResults.push(res);
    // }

    await rm(appPath, { recursive: true });

    return formatterResults;
  }

  static async runLinter(archive) {
    console.log("start");
    const appPath = "app";
    const zip = new AdmZip(Buffer.from(archive));
    zip.extractAllTo(appPath, true);

    const command = `make lint`;
    const linterResults = [];

    try {
      const { stdout, stderr } = await Utils.execAsync(command);
      console.log(stdout);
    } catch (err) {
      console.log(err);
    }

    await rm(appPath, { recursive: true });

    return linterResults;
  }
}
