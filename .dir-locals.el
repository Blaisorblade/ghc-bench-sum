; From https://github.com/commercialhaskell/intero/issues/195#issuecomment-239634535
((haskell-mode
  . ((eval . (with-current-buffer (intero-buffer 'backend)
           (intero-destroy)
           (intero-get-worker-create 'backend
                     '("bench-sum:BenchSum")
                     (current-buffer)))))))
