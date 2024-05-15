import { exec } from "child_process";
import { readFile } from "fs/promises";
import path from "path";

export class Utils {
  static execAsync(command, timeout = 10000) {
    return new Promise((resolve, reject) => {
      const process = exec(command, (error, stdout, stderr) => {
        if (error) {
          reject({ stdout, stderr });
        } else {
          resolve({ stdout, stderr });
        }
      });
      const timer = setTimeout(() => {
        process.kill();
        reject({
          stdout: `
          @Input: "" [E]
          Expected: ''
          Actual: 'Timeout exception: Execution time more ${timeout} ms'`,
        });
      }, timeout);
      process.on("exit", () => {
        clearTimeout(timer);
      });
    });
  }

  static parseTestInfo(stdout) {
    const regex = /Expected:\s'(.*?)'|Actual:\s'(.*?)'|@Input:\s"(.*?)".*?\[E/g;
    const matches = [];
    let match;

    while ((match = regex.exec(stdout)) !== null) {
      matches.push(match[1] || match[2] || match[3] || "");
    }

    return matches.slice(0, 3);
  }

  static parseFormattedFilePaths(stdout) {
    const filePaths = [];

    const lines = stdout.split("\n");
    for (const line of lines) {
      const matches = line.match(/Formatted\sapp\/([\w\/.-]+)/);
      if (matches && matches.length > 1) {
        const filePath = matches[1].replace(/^.*\//, "");
        filePaths.push(filePath);
      }
    }

    return filePaths;
  }

  static async getLinterOptions(sessionType) {
    switch (sessionType) {
      case "app":
        return readFile(path.resolve("linter_options", "app-option.yaml"));
      case "tasks":
        return readFile(path.resolve("linter_options", "tasks-option.yaml"));
      default:
        return "";
    }
  }

  static parseLinterFailedFiles(stdout) {
    const regex = /\w+ - ([^:]+):(\d+:\d+) - (.*) - (.*)/;

    const fileDataMap = new Map();
    const strings = stdout.split("\n");
    for (const str of strings) {
      const match = str.match(regex);
      if (match) {
        const path = match[1].trim().replace(/^.*\//, "");
        const [line, position] = match[2]
          .trim()
          .split(":")
          .map((item) => Number(item));
        const errorMessage = `${match[3].trim()} (position: ${position}, linter rule: ${match[4].trim()})`;

        const errorData = { line, messages: [errorMessage] };

        if (fileDataMap.has(path)) {
          const current = fileDataMap.get(path);
          const currentLineIndex = current.findIndex(
            (item) => item.line === line
          );

          if (currentLineIndex !== -1) {
            current[currentLineIndex].messages.push(errorMessage);
          } else {
            current.push(errorData);
          }
        } else {
          fileDataMap.set(path, [errorData]);
        }
      }
    }

    const linterFailedFiles = [...fileDataMap.entries()].map((item) => ({
      path: item[0],
      fileName: path.basename(item[0]),
      wrongLines: item[1],
    }));

    return linterFailedFiles;
  }
}
