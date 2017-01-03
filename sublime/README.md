# Sublime text config

* **Alt+click => go to definition**

```shell
cp sublime/Default\ \(OSX\).sublime-mousemap ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
```

* **php code sniffer**

    + Install SublimeLinter

    + Install SublimeLinter-phpcs

    + Edit user settings

    ```shell
    vim ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/SublimeLinter.sublime-settings
    ```
    
    
    + Paste this config

    ```json
    {
        "user": {
            "linters": {
                "phpcs": {
                    "@disable": false,
                    "args": [],
                    "excludes": ["*.html.php"],
                    "standard": "PSR2"
                }
            }
        }
    }
    ```