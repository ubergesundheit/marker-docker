makizushi = require 'makizushi'
express = require 'express'
fs = require 'fs'
app = express()

app.get '/marker/:marker', (req, res) ->

  marker = req.param("marker").replace(/\.png/,'')
  parts = marker.split("-",2)
  symbol_delimiter = if marker.indexOf('+') != -1 then marker.indexOf('+') else undefined
  symbol = marker.slice(marker.indexOf(parts[1])+parts[1].length+1,symbol_delimiter)
  color = '7e7e7e'
  if marker.indexOf('+') != -1
    color = marker.slice(marker.indexOf('+')+1).replace(/@2x/g,'')

  makizushi { base: parts[0], size: parts[1].charAt(0), tint: color, symbol: symbol, retina: marker.indexOf('@2x') != -1}
  ,(err, buf) ->
    unless err
      fs.writeFile "#{__dirname}/markers/#{marker}.png", buf
      res.set('Content-Type', 'image/png')
      res.send buf
    else
      res.json {message: "Marker \"#{marker}\" is invalid."}

  return

app.listen 8888
