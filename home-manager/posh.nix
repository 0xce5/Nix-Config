{
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    settings = builtins.fromJSON ''
      {
        "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
        "blocks": [
          {
            "alignment": "left",
            "segments": [
              {
                "background": "#f1184c",
                "foreground": "#242424",
                "powerline_symbol": "\ue0c4",
                "style": "powerline",
                "template": "\uf0e7",
                "type": "root"
              },
              {
                "background": "#282c34",
                "foreground": "#3A86FF",
                "leading_diamond": " ",
                "style": "diamond",
                "template": " {{ if .WSL }}WSL at {{ end }}{{.Icon}} ",
                "type": "os"
              },
              {
                "background": "#242424",
                "foreground": "#FFBB00",
                "powerline_symbol": "\ue0c4",
                "properties": {
                  "time_format": "15:04:05"
                },
                "style": "powerline",
                "template": "{{ .CurrentDate | date .Format }} ",
                "type": "time"
              },
              {
                "background": "#242424",
                "foreground": "#33DD2D",
                "powerline_symbol": "\ue0b0",
                "properties": {
                  "folder_separator_icon": "/",
                  "style": "folder"
                },
                "style": "powerline",
                "template": "\ue5ff {{ .Path }} ",
                "type": "path"
              },
              {
                "background": "#242424",
                "foreground": "#3A86FF",
                "powerline_symbol": "\ue0b0",
                "properties": {
                  "fetch_stash_count": true,
                  "fetch_status": true,
                  "fetch_upstream_icon": true
                },
                "style": "powerline",
                "template": "{{ .UpstreamIcon }}{{ .HEAD }}{{ if .Staging.Changed }} \uf046 {{ .Staging.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
                "type": "git"
              },
              {
                "background": "#0184bc",
                "foreground": "#ffffff",
                "powerline_symbol": "\ue0c4",
                "style": "powerline",
                "template": " \ue70c {{ if .Unsupported }}\uf071{{ else }}{{ .Full }}{{ end }} ",
                "type": "dotnet"
              },
              {
                "background": "#8800dd",
                "foreground": "#ffffff",
                "powerline_symbol": "\ue0c4",
                "properties": {
                  "style": "austin",
                  "threshold": 1
                },
                "style": "powerline",
                "template": " <#fefefe>\ueba2</> {{ .FormattedMs }} ",
                "type": "executiontime"
              },
              {
                "background": "#33DD2D",
                "background_templates": [
                  "{{ if gt .Code 0 }}#f1184c{{ end }}"
                ],
                "foreground": "#242424",
                "powerline_symbol": "\ue0b4",
                "style": "powerline",
                "template": " \ueb05 ",
                "type": "status"
              }
            ],
            "type": "prompt"
          },
          {
            "alignment": "left",
            "newline": true,
            "segments": [
              {
                "foreground": "#f1184c",
                "style": "plain",
                "template": "\u03bb ",
                "type": "text"
              }
            ],
            "type": "prompt"
          }
        ],
        "transient": {
          "background": "transparent",
          "foreground": "#f1184c",
          "template": "\u03bb "
        },
        "console_title_template": "{{if .Root}}(Admin) {{end}}{{.Folder}}",
        "version": 3
      }
    '';
  };
}
