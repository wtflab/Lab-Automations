import { writeFile, unlink } from "node:fs/promises";
import { Utils } from "./utils.js";

export class RunnerService {
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

    return testResults;
  }

  static async runFormatter(files) {
    const taskFilePath = "task.dart";

    const command = `make format`;
    const formatterResults = [];

    for (const file of files) {
      let res = {
        fileName: file.fileName,
        success: true,
      };

      await writeFile(taskFilePath, file.taskFile, "utf-8");

      const { stdout } = await Utils.execAsync(command);
      const changedLines = Utils.parseChangedCount(stdout);
      if (changedLines > 0) {
        res.success = false;
        console.log(`File ${file.fileName} failed formatter`);
      } else {
        console.log(`File ${file.fileName} passed formatter successfully`);
      }

      formatterResults.push(res);
    }

    await unlink(taskFilePath);

    return formatterResults;
  }

  static async runLinter(files) {
    const taskFilePath = "task.dart";

    const command = `make lint`;
    const linterResults = [];

    for (const file of files) {
      let res = {
        fileName: file.fileName,
        success: true,
        wrongLines: null,
      };

      await writeFile(taskFilePath, file.taskFile, "utf-8");

      try {
        await Utils.execAsync(command);
        console.log(`File ${file.fileName} passed linter successfully`);
      } catch ({ stdout }) {
        const wrongLines = Utils.filterErrorLines(stdout.split("\n"));
        res.success = false;
        res.wrongLines = wrongLines;

        console.log(`File ${file.fileName} failed linter: ${wrongLines}`);
      } finally {
        linterResults.push(res);
      }
    }

    await unlink(taskFilePath);

    return linterResults;
  }
}
