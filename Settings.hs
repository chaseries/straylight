{-# LANGUAGE OverloadedStrings #-}
module Settings where

import Data.Text


data AppSettings = AppSettings
  { appRoot :: Maybe Text
  , appPort :: Int
  , appStaticDir :: String
  }

currentSettingsThatMustBePutInYamlFile = AppSettings
  { appRoot = Just "http://localhost:9876"
  , appPort = 9876
  , appStaticDir = "static/"
  }
