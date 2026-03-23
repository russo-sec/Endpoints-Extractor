# Endpoints Extractor Tool

The **Endpoints Extractor by Russo-sec** is a Bash script designed to extract URLs and API endpoints from the HTML, JavaScript, and JSON content of web pages. This tool is useful for security researchers, bug bounty hunters, and developers looking to identify exposed endpoints within their applications.

## Features

* Scan a single URL or a list of URLs.
* Extract URLs absolutas and relative endpoints from HTML, JavaScript, and JSON content.
* Save the results to a file for further analysis.
* Timeout protection to avoid hanging on unresponsive targets.
* Simple and user-friendly interface.

## Prerequisites

* **Bash**: Ensure you are running the script in a Bash shell environment.
* **cURL**: The script uses `curl` to fetch web page content.
* **grep**: Used to extract URLs from the content.
* **sort**: Ensures the URLs are unique.

## Usage

### Display Help

```bash
./endpoints_extractor.sh -h
```

### Scan a Single URL

```bash
./endpoints_extractor.sh -u <URL>
```

Example:

```bash
./endpoints_extractor.sh -u https://example.com
```

### Scan a List of URLs

```bash
./endpoints_extractor.sh -l <FILE>
```

Example:

```bash
./endpoints_extractor.sh -l urls.txt
```

### Save Results to a File

```bash
./endpoints_extractor.sh -u <URL> -s <OUTPUT_FILE>
```

Example:

```bash
./endpoints_extractor.sh -u https://example.com -s results.txt
```

### Combined Example

Scan a list of URLs and save results to a file:

```bash
./endpoints_extractor.sh -l urls.txt -s endpoints.txt
```

## Options

| Flag | Description |
|------|-------------|
| `-u <URL>` | Specify a single URL to scan. |
| `-l <FILE>` | Specify a file containing a list of URLs. |
| `-s <FILE>` | Save the output to the specified file. |
| `-h` | Display the help message. |

## Example Output

For the URL `https://example.com`, the script may output:

```
[*] Scanning: https://example.com
https://example.com/api/v1/users
https://example.com/assets/js/script.js
https://cdn.example.com/library.js
/api/v1/login
/assets/css/style.css
[+] Resultados salvos em: results.txt
```

## Troubleshooting

* **Error: `-u` or `-l` must be specified**: Ensure you provide a URL with `-u` or a file with `-l`.
* **Error: File does not exist**: Verify the file path is correct.
* **Empty Output**: Ensure the target URL or file contains valid HTML, JS, or JSON content with endpoints.
* **Timeout**: The script enforces a 15-second timeout per request. Slow targets may be skipped.

## Disclaimer

This tool is intended for **authorized security testing and research only**. Do not use against targets without explicit permission. The author is not responsible for any misuse or damage caused by this tool.

---

*by Russo-sec*
