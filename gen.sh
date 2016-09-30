#!/bin/bash

outDir=compiler-outs

sayDo() {
    out=$outDir/$2
    echo '$' $1 > $out
    $1 2>&1 | tee -a $out
}

for resolver in 2.22 6.19 7.0; do
    ghcPath=$(stack --resolver lts-$resolver exec which ghc)
    # Prevent stack from reusing benchmarks built for another GHC.
    rm -rf .stack-work
    stack --resolver lts-$resolver build --bench --no-run-benchmarks
    sayDo "stack --resolver lts-$resolver exec -- ghc-core -w $ghcPath --no-syntax -- -O BenchSum.hs" BenchSum-lts-$resolver.corehs
    sayDo "stack --resolver lts-$resolver exec -- ghc-core -w $ghcPath -- -O BenchSum.hs" BenchSum-lts-$resolver-color.corehs
    sayDo "stack --resolver lts-$resolver bench" Zoutput-lts-$resolver.txt
done

echo "Cleaning out up output of ghc-core"
git clean -f -X BenchSum*
