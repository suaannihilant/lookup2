;;; support-muller.el --- support file for Mulelr's Dictionary Index
;; Copyright (C) 2009 Lookup Development Team

;;; Code:

;;; Customizable variables

(defvar support-muller-dict-pdf-list
  '(
    ;;("A Glossary of Zen Terms (Inagaki)")
    ;;("Buddhist Chinese-Sanskrit Dictionary (Hirakawa)")
    ;;("Bukkyo jiten (Ui)")
    ("Bukkyō daijiten (Mochizuki)" . support-muller-mochizuki-to-pdf)
    ;;("Bukkyō daijiten (Oda)")
    ;;("Bukkyōgo daijiten (Nakamura)")
    ;;("Bulgyo sajeon")
    ;;("Bussho kaisetsu daijiten (Ono)")
    ;;("Chūgoku bukkyōshi jiten (Kamata)")
    ;;("Chūgoku bukkyōshi jiten")
    ;;("DDB")
    ;;("Ding Fubao")
    ;;("Fo Guang Dictionary")
    ;;("Fo Guang Shan Dictionary")
    ;;("Han'guk bulgyo inmyeong sajeon (Yi)")
    ;;("Index to the Bussho kaisetsu daijiten (Ono)")
    ;;("Iwanami Bukkyō jiten")
    ;;("Japanese-English Buddhist Dictionary (Daitō shuppansha)")
    ;;("Japanese-English Zen Buddhist Dictionary (Yokoi)")
    ;;("Kankoku bussho kaidai jiten")
    ;;("Kattō gosen (Mujaku Dōchū)")
    ;;("Koga")
    ;;("Nihon bukkyō jinmei jiten (Saitō and Naruse)")
    ;;("Record of Linji: Rinzairoku (Yanagida)")
    ;;("Record of Mazu: Baso no goroku (Iriya)")
    ;;("Sanskrit-Tibetan Index for the Yogâcārabhūmi-śāstra (Yokoyama and Hirosawa)")
    ;;("Teihon zenrin kushō (Shibayama)")
    ;;("Zen Dust (Sasaki)")
    ;;("Zengaku daijiten (Komazawa U.)")
    ;;("Zengaku zokugokai (Genkyō Zenji)")
    ;;("Zengo jiten (Iriya and Koga)")
    ;;("Zenrin shōkisen (Mujaku Dōchū)")
    ))

(defun support-muller-mochizuki-to-pdf (page)
  "convert Mochizuki Dictionary to PDF page."
  ;; (v.1-6)(v.1-6)1989a
  ;; (v.9-10)24b
)

;(defvar support-jmdict-entry-tags-list
;  '(("<gloss xml:lang=\"rus\">" . "</gloss>")
;    ("<gloss xml:lang=\"ger\">" . "</gloss>")
;    ("<gloss xml:lang=\"fre\">" . "</gloss>")
;    ("<gloss>" . "</gloss>")
;    ("<reb>" . "</reb>")
;    ("<keb>" . "</keb>"))
;  "Tags to be searched.  You may edit the variables to reduce the
;searching time.")
;
;(defvar support-jmdict-replace-tags
;  '(("<gloss xml:lang=\"rus\">" . "ロシア語：")
;    ("<gloss xml:lang=\"ger\">" . "ドイツ語：")
;    ("<gloss xml:lang=\"fre\">" . "フランス語：")
;    ("<gloss>" . "英語：")
;    ("<reb>" . "かな：")
;    ("<keb>" . "漢字：")
;    ("<bib_txt>" . "書誌情報：")
;    ("<etym>" . "語源：")
;    ("<ent_seq>" . "語彙番号：")
;    ("<ke_inf>" . "漢字情報コード：")
;    ("<ke_pri>" . "漢字重要度：")
;    ("<dial>" . "方言：")
;    ("<example>" . "用例：")))
;
;
;(defvar support-jmdict-replace-tags-regexp
;  (regexp-opt
;   (mapcar 'car support-jmdict-replace-tags)))
;
;(defvar support-jmdict-replace-entities
;  '(
;    ("MA" . "martial arts term")
;    ("X" . "rude or X-rated term (not displayed in educational software)")
;    ("abbr" . "abbreviation")
;    ("adj-i" . "adjective (keiyoushi)")
;    ("adj-na" . "adjectival nouns or quasi-adjectives (keiyodoshi)")
;    ("adj-no" . "nouns which may take the genitive case particle `no'")
;    ("adj-pn" . "pre-noun adjectival (rentaishi)")
;    ("adj-t" . "`taru' adjective")
;    ("adj-f" . "noun or verb acting prenominally")
;    ("adj" . "former adjective classification (being removed)")
;    ("adv" . "adverb (fukushi)")
;    ("adv-to" . "adverb taking the `to' particle")
;    ("arch" . "archaism")
;    ("ateji" . "ateji (phonetic) reading")
;    ("aux" . "auxiliary")
;    ("aux-v" . "auxiliary verb")
;    ("aux-adj" . "auxiliary adjective")
;    ("Buddh" . "Buddhist term")
;    ("chem" . "chemistry term")
;    ("chn" . "children's language")
;    ("col" . "colloquialism")
;    ("comp" . "computer terminology")
;    ("conj" . "conjunction")
;    ("ctr" . "counter")
;    ("derog" . "derogatory")
;    ("eK" . "exclusively kanji")
;    ("ek" . "exclusively kana")
;    ("exp" . "Expressions (phrases, clauses, etc.)")
;    ("fam" . "familiar language")
;    ("fem" . "female term or language")
;    ("food" . "food term")
;    ("geom" . "geometry term")
;    ("gikun" . "gikun (meaning) reading")
;    ("hon" . "honorific or respectful (sonkeigo) language")
;    ("hum" . "humble (kenjougo) language")
;    ("iK" . "word containing irregular kanji usage")
;    ("id" . "idiomatic expression")
;    ("ik" . "word containing irregular kana usage")
;    ("int" . "interjection (kandoushi)")
;    ("io" . "irregular okurigana usage")
;    ("iv" . "irregular verb")
;    ("ling" . "linguistics terminology")
;    ("m-sl" . "manga slang")
;    ("male" . "male term or language")
;    ("male-sl" . "male slang")
;    ("math" . "mathematics")
;    ("mil" . "military")
;    ("n" . "noun (common) (futsuumeishi)")
;    ("n-adv" . "adverbial noun (fukushitekimeishi)")
;    ("n-suf" . "noun, used as a suffix")
;    ("n-pref" . "noun, used as a prefix")
;    ("n-t" . "noun (temporal) (jisoumeishi)")
;    ("num" . "numeric")
;    ("oK" . "word containing out-dated kanji")
;    ("obs" . "obsolete term")
;    ("obsc" . "obscure term")
;    ("ok" . "out-dated or obsolete kana usage")
;    ("on-mim" . "onomatopoeic or mimetic word")
;    ("pn" . "pronoun")
;    ("poet" . "poetical term")
;    ("pol" . "polite (teineigo) language")
;    ("pref" . "prefix")
;    ("prt" . "particle")
;    ("physics" . "physics terminology")
;    ("rare" . "rare")
;    ("sens" . "sensitive")
;    ("sl" . "slang")
;    ("suf" . "suffix")
;    ("uK" . "word usually written using kanji alone")
;    ("uk" . "word usually written using kana alone")
;    ("v1" . "Ichidan verb")
;    ("v2a-s" . "Nidan verb with 'u' ending (archaic)")
;    ("v4h" . "Yondan verb with `hu/fu' ending (archaic)")
;    ("v4r" . "Yondan verb with `ru' ending (archaic)")
;    ("v5" . "Godan verb (not completely classified)")
;    ("v5aru" . "Godan verb - -aru special class")
;    ("v5b" . "Godan verb with `bu' ending")
;    ("v5g" . "Godan verb with `gu' ending")
;    ("v5k" . "Godan verb with `ku' ending")
;    ("v5k-s" . "Godan verb - Iku/Yuku special class")
;    ("v5m" . "Godan verb with `mu' ending")
;    ("v5n" . "Godan verb with `nu' ending")
;    ("v5r" . "Godan verb with `ru' ending")
;    ("v5r-i" . "Godan verb with `ru' ending (irregular verb)")
;    ("v5s" . "Godan verb with `su' ending")
;    ("v5t" . "Godan verb with `tsu' ending")
;    ("v5u" . "Godan verb with `u' ending")
;    ("v5u-s" . "Godan verb with `u' ending (special class)")
;    ("v5uru" . "Godan verb - Uru old class verb (old form of Eru)")
;    ("v5z" . "Godan verb with `zu' ending")
;    ("vz" . "Ichidan verb - zuru verb (alternative form of -jiru verbs)")
;    ("vi" . "intransitive verb")
;    ("vk" . "Kuru verb - special class")
;    ("vn" . "irregular nu verb")
;    ("vr" . "irregular ru verb, plain form ends with -ri")
;    ("vs" . "noun or participle which takes the aux. verb suru")
;    ("vs-s" . "suru verb - special class")
;    ("vs-i" . "suru verb - irregular")
;    ("kyb" . "Kyoto-ben")
;    ("osb" . "Osaka-ben")
;    ("ksb" . "Kansai-ben")
;    ("ktb" . "Kantou-ben")
;    ("tsb" . "Tosa-ben")
;    ("thb" . "Touhoku-ben")
;    ("tsug" . "Tsugaru-ben")
;    ("kyu" . "Kyuushuu-ben")
;    ("rkb" . "Ryuukyuu-ben")
;    ("vt" . "transitive verb")
;    ("vulg" . "vulgar expression or word")))
;
;(defvar support-jmdict-replace-entities-regexp
;  (concat "&\\("
;          (regexp-opt
;           (mapcar 'car support-jmdict-replace-entities))
;          "\\);"))
;
;(defun support-jmdict-arrange-structure (entry)
;  "Arrange Structure of ENTRY."
;  (goto-char (point-min))
;  (while (re-search-forward support-jmdict-replace-tags-regexp nil t)
;    (replace-match
;     (cdr (assoc (match-string 0) support-jmdict-replace-tags))))
;  (goto-char (point-min))
;  (while (re-search-forward support-jmdict-replace-entities-regexp nil t)
;    (replace-match
;     (cdr (assoc (match-string 1) support-jmdict-replace-entities))))
;  (goto-char (point-min))
;  (while (re-search-forward "<.+?>" nil t)
;    (replace-match ""))
;  (goto-char (point-min))
;  (if (looking-at "\n") (delete-region (point-min) (1+ (point-min))))
;  (goto-char (point-min))
;  (while (re-search-forward "\\([ 	]*\n\\)+" nil t)
;    (replace-match "\n"))
;  (goto-char (point-min))
;  (while (re-search-forward "語彙番号：[0-9]+" nil t)
;    (lookup-make-region-heading (match-beginning 0) (match-end 0) 1))
;  )

(setq lookup-support-options
      (list :title "仏教関連辞典"
            :arranges '((reference support-jmdict-arrange-structure))
            :entry-tags-list '(("<hdwd>" . "</hdwd>") ("\">" . "</pron>"))
            :content-tags '("<entry" . "</entry>")
            :head-tags '("<hdwd>" . "</hdwd>")
            :code-tags '("ID=\"" . "\">")
            :coding 'utf-8
            )) ;; <keb>..</keb> or <reb>..</reb>

;;; support-jmdict.el ends here
