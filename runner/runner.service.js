import { writeFile, unlink, rm } from "node:fs/promises";
import { Utils } from "./utils.js";
import AdmZip from "adm-zip";

export class RunnerService {
  // добавить InPUT
  static async runTests(files) {
    const taskFilePath = "task.dart";
    const testFilePath = "test.dart";

    const command = `make test`;
    const testResults = [];

    for (const file of files) {
      let res = {
        fileName: file.fileName,
        success: true,
        wrongTest: null,
        fatal: false,
      };

      await writeFile(taskFilePath, file.taskFile, "utf-8");
      await writeFile(testFilePath, file.testFile, "utf-8");

      try {
        await Utils.execAsync(command);
        console.log(`File ${file.fileName} passed tests successfully`);
      } catch ({ stdout }) {
        const isFatal = stdout.includes("Failed to load");
        res.success = false;

        if (isFatal) {
          console.log(`Failed to load ${file.fileName}`);
          res.fatal = true;
          continue;
        }

        const errorMessage = Utils.parseTestErrorMessage(stdout);
        res.wrongTest = errorMessage;
        console.log(
          `File ${file.fileName} didn't pass test. Expected: "${errorMessage[0]}" Actual: "${errorMessage[1]}"`
        );
      } finally {
        testResults.push(res);
      }
    }

    await unlink(taskFilePath);
    await unlink(testFilePath);

    console.log(testResults);

    return testResults;
  }

  static async runFormatter(archive) {
    console.log("start");
    const appPath = "app";
    const zip = new AdmZip(Buffer.from(archive));
    zip.extractAllTo(appPath, true);

    const command = `make format`;
    const formatterResults = [];

    const { stdout } = await Utils.execAsync(command);

    console.log(stdout);

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
