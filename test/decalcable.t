  $ decalcable -e '42'
  42

  $ decalcable -e '42 + 0'
  42

  $ decalcable -e 'foo : 42'
  42

  $ decalcable -e 'foo'
  decalque: internal error, uncaught exception:
            Failure("Unbound variable")
            
  [125]
