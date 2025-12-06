(values [] [(s "%%" (fmt "<% {} %>" [(i 1)] {:delimiters "{}"}))
            (s "%=" (fmt "<%= {} %>" [(i 1)] {:delimiters "{}"}))
            (s "%i" (fmt "<% if {} %>\n{}\n<% end %>" [(i 1) (i 2)]
                         {:delimiters "{}"}))
            (s "%e" (t "<% end %>"))])
