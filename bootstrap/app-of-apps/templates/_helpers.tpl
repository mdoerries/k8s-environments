{{/*
Merged den Component-Katalog (.Values.components) mit den Env-Overrides
(.Values.componentOverrides, Merge-Key ist .name) und gibt nur die aktivierten
Components als YAML-Liste zurueck.
*/}}
{{- define "app-of-apps.components" -}}
{{- $overrides := dict -}}
{{- range (.Values.componentOverrides | default list) -}}
{{- $_ := set $overrides .name . -}}
{{- end -}}
{{- $result := list -}}
{{- range .Values.components -}}
{{- $component := deepCopy . -}}
{{- if hasKey $overrides $component.name -}}
{{- $component = mergeOverwrite $component (get $overrides $component.name) -}}
{{- end -}}
{{- if $component.enabled -}}
{{- $result = append $result $component -}}
{{- end -}}
{{- end -}}
{{- toYaml $result -}}
{{- end -}}
