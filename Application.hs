module Application where


import Yesod
import Settings (currentSettingsThatMustBePutInYamlFile)
import Foundation


straylightMain :: IO ()
straylightMain = warp 9090 (Straylight currentSettingsThatMustBePutInYamlFile)
