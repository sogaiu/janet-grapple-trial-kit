(+ 1 2)

(import ./sample-lib :as sl)

(defn my-fn
  [x]
  (+ x (sl/lib-fun -1)))

(my-fn 3)

