# Change Log
## 2019-06-07
### Added
- added weapon swapping
  - weapons on the floor appear as icons
- added Frontliner (gun)
- added recoil animations to Pathfinder and Frontliner
- added invulnerability frames for 0.5s after taking damage (players only)
- added flexibility for future weapons (different modes)

### Changed
- updated enemy model (in black holding a dagger and gun)
- changed string-based variables to integer (i.e. "ranged" to 0, "melee" to 1)

### Other
- 

## 2019-06-04
### Added
- added Pathfinder (gun)
- added gun fire
- added pausing 
- added rate of fire
- added player animation
- added roll
- added invulnerability frames when rolling
- updated player image
- player and enemy char now turn red when dead (death not implemented yet)
- added ability to control player and enemy char independently (WASD / arrow keys)
- player and enemy gun both fire to cursor (for debugging purposes)

### Changed
- adjusted hitbox size of player
- adjusted volume of sounds

### Other
- seperate file to store keybinding
- seperated input related functions into another file
- seperated weapon related functions into weapon file
- created animation file
