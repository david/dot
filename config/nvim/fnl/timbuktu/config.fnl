(lambda make-table [& args]
  (var hashmap {})
  (var sequential [])
  (each [_ val (ipairs args)]
    (if (= (type val) :table)
        (set hashmap (vim.tbl_extend :force hashmap val))))
  (each [_ val (ipairs args)]
    (when (not= (type val) :table)
      (table.insert sequential val)))
  (values sequential hashmap))

(lambda kv [& args]
  (let [(sequential tbl) (make-table ...)]
    (vim.tbl_extend :force sequential tbl)))

(lambda vk [...]
  (let [(sequential tbl) (make-table ...)]
    (vim.tbl_extend :force tbl sequential)))

(lambda setup [repo-or-spec ?spec]
  (case [repo-or-spec ?spec]
    (where [repo nil] (= (type repo) :string)) [repo]
    (where [spec nil] (= (type spec) :table)) spec
    [repo spec] (kv repo spec)))

{: kv : setup : vk}
