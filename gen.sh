#!/bin/bash

outDir=compiler-outs

sayDo() {
    out=$outDir/$2
    echo '$' $1 > $out
    $1 2>&1 | tee -a $out
}

clean() {
    rm -f BenchSum.hi
}

for resolver in 2.22 6.19 7.0; do
    # Prevent stack from reusing benchmarks built for another GHC.
    rm -rf .stack-work
    stack --resolver lts-$resolver build --bench --no-run-benchmarks
    sayDo "stack --resolver lts-$resolver exec -- ghc-core --no-syntax -- -O BenchSum.hs" BenchSum-lts-$resolver.corehs
    clean
    sayDo "stack --resolver lts-$resolver exec -- ghc-core -- -O BenchSum.hs" BenchSum-lts-$resolver-color.corehs
    clean
    sayDo "stack --resolver lts-$resolver bench" Zoutput-lts-$resolver.txt
done

echo "Cleaning out up output of ghc-core"
git clean -f -X BenchSum*
