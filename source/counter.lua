import "CoreLibs/object"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Counter").extends()

function Counter:init(totalStitches, totalRows, x, y)
  Counter.super.init(self)
  self.stitches = {
    total = totalStitches,
    current = 0
  }
  self.rows = {
    total = totalRows,
    current = 0
  }

  self.x = x
  self.y = y
end

function Counter:increment(amount)
  self.stitches.current = self.stitches.current + amount
  if (self.stitches.current >= self.stitches.total) then
    -- if the stitches for the current row have been filled up
    -- substract the amount of stitches for each row from the current stitch count
    self.stitches.current = self.stitches.current - self.stitches.total
    -- and then increment the row counter
    self.rows.current = self.rows.current + 1
  end
end

function Counter:decrement(amount)
  -- don't decrease stitches, if there are no completed rows or stitches
  self.stitches.current = self.stitches.current - amount
  if (self.stitches.current < 0 and self.rows.current == 0) 
  then
    self.stitches.current = 0
  elseif (self.stitches.current < 0)
  then
    -- if the current amount of stitches is decreased to a negative number, decrease rows by 1
    -- stitches.current is a negative number, so it's added to decrease number stitches.total
    self.stitches.current = self.stitches.total + self.stitches.current
    self.rows.current = self.rows.current - 1
  end
end

function Counter:update()
  function pd.AButtonDown() 
    self.increment(self, 1)
  end
  function pd.BButtonDown() 
    self.decrement(self, 1)
  end
end

function Counter:draw()
  local finishedStitches = string.format("Stitches: %d/%d", self.stitches.current, self.stitches.total)
  local finishedRows = string.format("Rows: %d/%d", self.rows.current, self.rows.total)
  gfx.drawText(finishedStitches, self.x, self.y)
  gfx.drawText(finishedRows, self.x, self.y + 50)
end