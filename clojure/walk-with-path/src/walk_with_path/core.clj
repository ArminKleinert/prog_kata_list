(ns walk-with-path.core
  (:import (java.util Random)))

; SECTION The actual walking

(defn walk-with-path
  "Walks a collection 'coll' (Map, Record, Vector or List) and applies a function 'f'
  to each element and the path leading there (element first, then the path).
  Attention: The path is a list in reverse order! (Keys are prepended)."
  ([f coll]
   (walk-with-path f coll (list)))
  ([f coll _path]
   (cond
     ; Vector
     (vector? coll)
     (-> (fn [i v]
           (let [path (cons i _path)]
             (walk-with-path f (f v path) path)))
         (mapv (range) coll)
         (vec))

     ; List or array
     (sequential? coll)
     (doall
       (map
         (fn [i v]
           (let [path (cons i _path)]
             (walk-with-path f (f v path) path)))
         (range)
         coll))

     ; Map or record
     (map? coll)
     (->> coll
          (mapv (fn [[k v]]
                  (let [path (cons k _path)]
                    (vector k (walk-with-path f (f v path) path)))))
          (into {}))

     ; Set
     (set? coll)
     (-> (fn [v]
           (let [path (cons v _path)]
             (walk-with-path f (f v path) path)))
         (map coll)
         (set))

     ; coll is not a collection
     :else (f coll _path)
     )))

(defn walk-with-path-2
  "Walks a collection 'coll' (Map, Record, Vector or List) and applies a function 'f'
  to each element and the path leading there (element first, then the path).
  Attention: The path is a sequential collection (vector is optimal) in normal order
  (new keys are appended at the end)."
  ([f coll]
   (walk-with-path-2 f coll []))
  ([f coll _path]
   (cond
     ; Vector
     (vector? coll)
     (-> (fn [i v]
           (let [path (conj _path i)]
             (walk-with-path-2 f (f v path) path)))
         (mapv (range) coll)
         (vec))

     ; List or array
     (sequential? coll)
     (doall
       (map
         (fn [i v]
           (let [path (conj _path i)]
             (walk-with-path-2 f (f v path) path)))
         (range)
         coll))

     ; Map or record
     (map? coll)
     (->> coll
          (mapv (fn [[k v]]
                  (let [path (conj _path k)]
                    (vector k (walk-with-path-2 f (f v path) path)))))
          (into {}))

     ; Set
     (set? coll)
     (-> (fn [v]
           (let [path (conj _path v)]
             (walk-with-path-2 f (f v path) path)))
         (map coll)
         (set))

     ; coll is not a collection
     :else (f coll _path)
     )))

(defn walk-with-path-3
  "Walks a collection 'coll' (Map, Record, Vector or List) and applies a function 'f'
  to each element and the path leading there (element first, then the path).
  Attention: The path is a sequential collection (vector is optimal) in normal order
  (new keys are appended at the end)."
  ([f coll]
   (walk-with-path-2 f coll []))
  ([f coll _path]
   (cond
     ; Vector
     (vector? coll)
     (-> (fn [i v]
           (let [path (conj _path i)]
             (walk-with-path-3 f (f v path) path)))
         (map-indexed coll)
         (vec))

     ; List or array
     (sequential? coll)
     (doall
       (map-indexed
         (fn [i v]
           (let [path (conj _path i)]
             (walk-with-path-3 f (f v path) path)))
         coll))

     ; Map or record
     (map? coll)
     (->> coll
          (mapv (fn [[k v]]
                  (let [path (conj _path k)]
                    (vector k (walk-with-path-3 f (f v path) path)))))
          (into {}))

     ; Set
     (set? coll)
     (-> (fn [v]
           (let [path (conj _path v)]
             (walk-with-path-3 f (f v path) path)))
         (map coll)
         (set))

     ; coll is not a collection
     :else (f coll _path)
     )))

; SECTION Time measurement

(defmacro ^Double millis
  [expr]
  `(let [start# (. System (nanoTime))]
     ~expr
     (/ (double (- (. System (nanoTime)) start#)) 1000000.0)))

(defn average-millis
  [times expr]
  (let [meridian (fn [arr]
                   (let [arr (sort arr)
                         len (count arr)]
                     (/ (+ (nth arr (/ (dec len) 2)) (nth arr (/ len 2)))
                        2)))]
    (meridian (repeatedly times (fn [] (millis (expr)))))))

; SECTION Generating test-data

(defn rand1
  [random maximum]
  (.nextInt random maximum))

(defn gen-rand-structure
  ([n nodes-per-level]
   (gen-rand-structure n nodes-per-level (Random. 0xDEADBEEF)))
  ([n nodes-per-level random]
   (if (<= n 0)
     (rand1 random 10000)
     (case (rand1 random 4)
       0 (doall
           (repeatedly nodes-per-level
             #(gen-rand-structure (dec n) nodes-per-level random)))

       1 (vec (repeatedly nodes-per-level
                #(gen-rand-structure (dec n) nodes-per-level random)))

       2 (->> (fn [] [(str (rand1 random 200000))
                      (gen-rand-structure (dec n) nodes-per-level random)])
              (repeatedly nodes-per-level)
              (apply concat)
              (apply hash-map))

       3 (->> (fn [] [(str (rand1 random 200000))
                      (gen-rand-structure (dec n) nodes-per-level random)])
              (repeatedly nodes-per-level)
              (apply concat)
              (set))

       (rand1 random 10000)
       ))))

(defn -main
  [& args]
  )

(comment
  ; Create test data
  (def test-data (vec (gen-rand-structure 7 5)))

  ; Do a simple walk (Warning: Running this in the repl on a big collection will
  ; lock for a long time because of printing
  (walk-with-path (fn [elem path] elem) test-data)

  ; Test speed of creation of test data
  (average-millis 15 #(gen-rand-structure 7 5))

  ; Test speed of non-traversal
  (average-millis 15 #(walk-with-path (fn [elem path] elem) test-data))

  ; Do a walk with a bit more work (emulated, does nothing productive)
  (average-millis 15 #(walk-with-path (fn [elem path] (str path) elem) test-data))

  ; Do a walk with a bit more work
  (average-millis 15 #(walk-with-path-2 (fn [elem path] (str path) elem) test-data))

  (average-millis 15 #(walk-with-path (fn [elem path] (str path) elem) test-data))
  (average-millis 15 #(walk-with-path-2 (fn [elem path] (str path) elem) test-data))
  (average-millis 15 #(walk-with-path-3 (fn [elem path] (str path) elem) test-data))
  )
