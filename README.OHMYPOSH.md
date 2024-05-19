# Oh My Posh

1. Type -> (prompt, rprompt)
2. Newline -> (false) Start the block on a new line
3. Alignment -> (left, right)
4. Filler -> ()
5. Overflow -> (break, hide)

## Style

- powerline
- plain
- diamond
- accordion

## Template

{{.}} : Root element.
{{.Var}} : Variable in sturct, where Var is a variable.
{{ $plant := "Earth" }} : Custom Variable to ref later
Hi {{if .Name}} {{.Name}} {{else}} visitor {{end}}
{{if and .Arg1 .Arg2}} both complete. {{else}} imcomplete. {{end}}
{{with .Var}} {{end}}
{{ lt 3 4 }}

## Segments Example

```json
"blocks": [
    {
      ...
      "segments": [
        {
          "type": "path",
          "style": "powerline",
          "powerline_symbol": "\uE0B0",
          "foreground": "#ffffff",
          "background": "#61AFEF",
          "template": " {{ .Path }}} ",
          "properties": {
            ...
          }
        }
      ]
    }
  ]
```

$ oh-my-posh print primary --config .\VivPrompt.json --shell uni

! final_space
! pwd
! terminal_background
! accent_color
! var
! shell_integration
