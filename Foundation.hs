{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
module Foundation where

import Yesod
import Data.Text
--import Text.Blaze
--import Text.Blaze.Html.Renderer.String (renderHtml)
import Text.Hamlet (hamletFile)
import ClassyPrelude.Yesod

import Database.Persist.Sql (ConnectionPool, runSqlPool)
import System.FilePath.Posix ((</>))
import Settings (AppSettings, appRoot, currentSettingsThatMustBePutInYamlFile)

data Straylight = Straylight
  { appSettings :: AppSettings
  }

mkYesod "Straylight" $(parseRoutesFile "config/routes")

instance Yesod Straylight where

  approot = ApprootRequest $ \app req ->
    case appRoot $ appSettings app of
      Nothing -> getApprootText guessApproot app req
      Just root -> root

  defaultLayout widget = do
    pc <- widgetToPageContent widget
    let layoutHeader = $(hamletFile "templates/components/layoutHeader.hamlet")
    withUrlRenderer $(hamletFile "templates/boilerplate.hamlet")


getHomeR :: Handler Html
getHomeR = defaultLayout $ do
  setTitle "Straylight"
  let someVar = "<div>Something inside a div</div>" :: String
  $(whamletFile "templates/pages/home.hamlet")


getLoginR :: Handler Html
getLoginR = defaultLayout $ do
  setTitle "Login"
  $(whamletFile "templates/pages/login.hamlet")
