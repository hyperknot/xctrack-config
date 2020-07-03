#!/usr/bin/env bash

rm -f screens/compare*

# MODE=por
# MODENAME=portrait

MODE=lan
MODENAME=landscape


cp screens/hyperknot-$MODENAME.xcfg screens/compare.xcfg


gsed -i "s|org.xcontest.XCTrack.widget.w.WCompMap|org.xcontest.XCTrack.widget.w.WXCAssistant|g" screens/compare.xcfg

./process.py screens/compare.xcfg compare-nocomp -$MODE -nocomp
./process.py screens/compare.xcfg compare-onlycomp -$MODE -onlycomp

rm screens/compare.xcfg

gsed -i 's|"UUID".*||g' screens/compare-*.xcfg
gsed -i 's|"X1".*||g' screens/compare-*.xcfg
gsed -i 's|"X2".*||g' screens/compare-*.xcfg
gsed -i 's|"Y1".*||g' screens/compare-*.xcfg
gsed -i 's|"Y2".*||g' screens/compare-*.xcfg


mv screens/{,$MODE-}compare-nocomp.xcfg
mv screens/{,$MODE-}compare-onlycomp.xcfg

