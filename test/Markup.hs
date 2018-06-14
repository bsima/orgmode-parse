{-# LANGUAGE OverloadedStrings #-}

module Markup where

import           Test.Tasty
import           Test.Tasty.HUnit
import           Data.OrgMode.Parse.Attoparsec.Markup
import           Util


parserMarkupTests :: TestTree
parserMarkupTests = testGroup "Attoparsec orgmode markup"
  [ testCase "Parses bold words" $
      testDocS "*bold*" (Bold "bold")
  , testCase "Parses italic words" $
      testDocS "/italic words/" (Italic "italic words")
  , testCase "Parses underlined text" $
      testDocS "_underlined stuff_" (Underline "underlined stuff")
  , testCase "Parses monospace text" $
      testDocS "=verbatim=" (Monospace "verbatim")
  , testCase "Parses code" $
      testDocS "~some code~" (Code "some code")
  , testCase "Parses strikethrough" $
      testDocS "+strike this+" (Strike "strike this")

  , testCase "Parses subscript" $
      testDocS "_sun " (Subscript "sun")
  , testCase "Parses subscript with curly braces" $
      testDocS "_{Alpha Centauri} " (Subscript "Alpha Centauri")

  , testCase "Parses superscript" $
      testDocS "^10 " (Subscript "10")
  , testCase "Parses subscript with curly braces" $
      testDocS "^{ref 1} " (Subscript "ref 1")
  ]
  where
    testDocS s r = expectParse parseMarkup s (Right r)