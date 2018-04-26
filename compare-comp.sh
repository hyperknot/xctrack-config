#!/usr/bin/env bash

rm -f screens/compare*

MODE=por
MODENAME=portrait

# MODE=lan
# MODENAME=landscape


cp screens/hyperknot-$MODENAME.cfg screens/compare.cfg


gsed -i "s|org.xcontest.XCTrack.widget.w.WCompMap|org.xcontest.XCTrack.widget.w.WXCAssistant|g" screens/compare.cfg

./process.py screens/compare.cfg compare-nocomp -$MODE -nocomp
./process.py screens/compare.cfg compare-onlycomp -$MODE -onlycomp

rm screens/compare.cfg

gsed -i 's|"UUID".*||g' screens/compare-*.cfg
gsed -i 's|"X1".*||g' screens/compare-*.cfg
gsed -i 's|"X2".*||g' screens/compare-*.cfg
gsed -i 's|"Y1".*||g' screens/compare-*.cfg
gsed -i 's|"Y2".*||g' screens/compare-*.cfg


mv screens/{,$MODE-}compare-nocomp.cfg
mv screens/{,$MODE-}compare-onlycomp.cfg

