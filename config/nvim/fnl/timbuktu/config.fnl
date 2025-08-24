(lambda kv [& args]
  (var hashmap {})
  (var sequential [])
  (each [_ val (ipairs args)]
    (if (= (type val) :table)
        (set hashmap (vim.tbl_extend :force hashmap val))))
  (each [_ val (ipairs args)]
    (when (not= (type val) :table)
      (table.insert sequential val)))
  (vim.tbl_extend :force sequential hashmap))

(lambda setup [repo-or-spec ?spec]
  (case [repo-or-spec ?spec]
    (where [repo nil] (= (type repo) :string)) [repo]
    (where [spec nil] (= (type spec) :table)) spec
    [repo spec] (kv repo spec)))

{: kv : setup}
