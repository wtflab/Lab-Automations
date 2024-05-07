import { exec } from "child_process";

export class Utils {
  static parseTestErrorMessage(stdout) {
    const regex = /Expected:\s'(.*?)'|Actual:\s'(.*?)'/g;
    const matches = [];
    let match;

    while ((match = regex.exec(stdout)) !== null) {
      matches.push(match[1] || match[2] || "");
    }

    return matches;
  }

  static execAsync(command) {
    return new Promise((resolve, reject) => {
      exec(command, (error, stdout, stderr) => {
        if (error) {
          reject({ stdout, stderr });
        } else {
          resolve({ stdout, stderr });
        }
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
