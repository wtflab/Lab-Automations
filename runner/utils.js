import { exec } from "child_process";

export class Utils {
  static parseTestInfo(stdout) {
    const regex = /Expected:\s'(.*?)'|Actual:\s'(.*?)'|@Input:\s"(.*?)".*?\[E/g;
    const matches = [];
    let match;

    while ((match = regex.exec(stdout)) !== null) {
      matches.push(match[1] || match[2] || match[3] || "");
    }

    return matches.slice(0, 3);
  }

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
          Actual: 'Timeout exception: Function execution time more 500 ms'`,
        });
      }, timeout);
      process.on("exit", () => {
        clearTimeout(timer);
      });
    });
  }

  static parseChangedCount(line) {
    const match = line.match(/Formatted 1 file \((\d+) changed\)/);
    if (match) {
      const changedCount = parseInt(match[1]);
      return changedCount;
    }
    return 0;
  }

  static filterErrorLines(lines) {
    const filteredLines = [];
    const errorLabel = "error - task.dart:";

    for (const line of lines) {
      if (line.includes(errorLabel)) {
        const parsedSubstring = line.trim().slice(errorLabel.length);
        filteredLines.push(parsedSubstring);
      }
    }

    return filteredLines;
  }

  static parseErrorLine(line) {
    const startIndex = line.includes("error - task.dart:");
    if (startIndex !== -1) {
      return line.substring(startIndex);
    }
    return null;
  }
}
