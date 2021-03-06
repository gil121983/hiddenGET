*/

/* Rule Set ----------------------------------------------------------------- */

rule obfus_bitwise {
   meta:
      description = "Obfuscated bitwise"
      author = "Gil Stolar"
      reference = "https://github.com/gil121983/obfuscatedPHP"
      date = "2021-01-06"
   strings:
      $re1 = /\(.{1,}[\&\^\|\>{2}\<{2}]".{1,}"\)\.\(.{1,}[\&\^\|\>{2}\<{2}]".{1,}"\)\.\(.{1,}[\&\^\|\>{2}\<{2}]".{1,}"\)/ wide ascii fullword

   condition:
      all of them
}

rule suspicious_concat {
   meta:
      description = "suspicious concatenation"
      author = "Gil Stolar"
      reference = "https://github.com/gil121983/obfuscatedPHP"
      date = "2021-01-06"
   strings:
      $re1 = /(\$.{1,}\[\d\]\.){5,}/ wide ascii fullword
      $re2 = /\b.{1,}eval\(\$.{1,}\(\$.{1,}\)\)/ wide ascii
      $re3 = /\b.{1,}strto(upper|lower)\(\$.{1,}\[\d\]\).{1,}\b/ wide fullword
   condition:
      2 of them
}

rule suspicious_replace {
   meta:
      description = "suspicious replace"
      author = "Gil Stolar"
      reference = "https://github.com/gil121983/obfuscatedPHP"
      date = "2021-01-12"
   strings:
      $re1 = /\b.{1,}str_replace\(array.{1,}(\&\#59|\&lt|\&gt|\&\#63|\&\#34|G\&\#69|\&\#47|POST|GET|http:)*4.{1,}\b/ wide ascii fullword
   condition:
      #re1 > 1
}

rule suspicious_function_call {
   meta:
      description = "suspicious function call"
      author = "Gil Stolar"
      reference = "https://github.com/gil121983/obfuscatedPHP"
      date = "2021-01-13"
   strings:
      $re1 = /\(.{1,}\$.{1,}\=.{1,}\(.{1,}\)\)\.[^a-bA-B0-9]\$[^\=\$\(]\(.{1,}\)/ wide ascii fullword
      //$re2 = /\beval\(.{0,1}\$.{1,}\(\$.{1,}\)\)/ wide fullword ascii nocase
      $re3 = /^\<\?php.{1,}(\$\{("|')_("|')\.\$.\}.{1,}){2,}/ nocase
      //$re4 = /eval\(("|')\\\$/
      $re5 = /.{1,}\$_{1,}.{1,}assert\(\$_POST.{1,}/ wide nocase ascii
      //$re6 = /str_replace(\(.{1,}(\$.{1,}\.){7,})/
      //$re7 = /(<\?php|<\?\=|r[;{}])[ \t]*@?(preg_replace|str_replace|eval|system|passthru|(pcntl_)?exec|shell_exec|call_user_func(_array)?)\s*\(/ nocase
   condition:
      1 of them
}


rule concatenated_post {
   meta:
      description = "concatenated post request"
      author = "Gil Stolar"
      reference = "https://github.com/gil121983/obfuscatedPHP"
      date = "2021-01-14"
   strings:
      $re = /["'asertPOST\.{3,12}\n\}]{{0,1}(("|')_P[^OST]{0,20}("\."|'\."){0,1}O[^ST]{0,20}("\."|'\.'){0,1}S[^T]{0,11}("\."|'\.'){0,1}[^POS]{0,20}T("}))/ wide ascii
   condition:
      all of them
}

rule function_name_manipulation {
   meta:
      description = "Manipulated function name with $_POST as argument"
      author = "Gil Stolar"
      reference = "https://github.com/gil121983/obfuscatedPHP"
      date = "2021-01-14"
   strings:
      $re1 = /(<\?php|<\?\=).{,20}([\<\?sert\.\(]{5,}.{1,20}){7,20}.{,20}_POST/  ascii nocase wide
      $re2 = /\$.{1,20}\(\$_POST/ ascii nocase
   condition:
      all of them
}

