#!/usr/bin/env bash

rm -f screens/compare*

cp screens/hyperknot-landscape.cfg screens/compare.cfg
gsed -i "s|org.xcontest.XCTrack.widget.w.WCompMap|org.xcontest.XCTrack.widget.w.WXCAssistant|g" screens/compare.cfg

./process.py screens/compare.cfg compare-nocomp -lan -nocomp
./process.py screens/compare.cfg compare-onlycomp -lan -onlycomp

rm screens/compare.cfg

gsed -i 's|"UUID".*||g' screens/compare-*.cfg
gsed -i 's|"X1".*||g' screens/compare-*.cfg
gsed -i 's|"X2".*||g' screens/compare-*.cfg
gsed -i 's|"Y1".*||g' screens/compare-*.cfg
gsed -i 's|"Y2".*||g' screens/compare-*.cfg
