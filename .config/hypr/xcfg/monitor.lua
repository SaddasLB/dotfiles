-- See https://wiki.hypr.land/configuring/core/monitors/

------------------
---- MONITORS ----
------------------

-- Standard
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto",
})

-- GS65 Stealth Thin 8RF
hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@144",
  position = "0x0",
  scale = 1,
})
