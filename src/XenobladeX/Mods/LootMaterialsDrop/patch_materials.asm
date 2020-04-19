[XCX_LOOT_MATERIALS_1E2U]
moduleMatches = 0xF882D5CF, 0x30B6E091 ; 1.0.1E, 1.0.2U

0x030FA650 = _mtRand:

0x02B09748 = nop
0x02B09788 = nop
;0x02B09864 = nop

[XCX_LOOT_MATERIALS_1U]
moduleMatches = 0xAB97DE6B ; 1.0.1U

0x030FA4D4 = _mtRand:

;0x02B096BC = nop
;0x02B096FC = nop
;0x02B097D8 = nop

[XCX_LOOT_MATERIALS]
moduleMatches = 0xF882D5CF, 0x30B6E091, 0xAB97DE6B ; 1.0.1E, 1.0.2U, 1.0.1U

.origin = codecave

; ----------------------------------------------------------------------------
; WHO  : __CPR90__calcItemBronze__Q2_8ItemDrop16CItemDropManagerFRQ3_J19JJ28J9SDropInfoUc
; WHAT : Affect the drop ratio of materials

.int $ratio

_minDropRate:
	li r11, $ratio
	li r31, 0
	cmpwi r11, 0
	beqlr
	cmpw r31, r11 ; this value is the default drop ratio under which we want to set a new drop ratio (logically equal or greater)
	blt newdrop
	b compare
newdrop:
	mr r31, r11 ; here you set the new drop ratio
compare:
	cmpw r3, r31
	blr

0x021AF5DC = bla _minDropRate ; modify drop ratio for bronze chests
0x021AF614 = bla _minDropRate ; modify drop ratio for silver chests
0x021AF5F8 = bla _minDropRate ; modify drop ratio for gold chests

; ----------------------------------------------------------------------------
; WHO  : __CPR90__calcItemBronze__Q2_8ItemDrop16CItemDropManagerFRQ3_J19JJ28J9SDropInfoUc
; WHAT : random selection when all materials at 100% and more than 5

; si 6e a 100% chances, les autres ont entre 50% (1/2) et 80% (4/5) de chances de rester

_saveEquipCnt:
	mr r30, r4
	lwz r13, 0xE0(r30)
	blr
0x021AF334 = bla _saveEquipCnt

;_myRand = 0x00000080
;0x00000080 = mflr r0
;0x00000084 = lis r8, _mtRand@ha
;0x00000088 = addi r8, r8, _mtRand@l
;0x0000008C = mtctr r8
;0x00000090 = bctrl
;0x00000094 = mtlr r0
;0x00000098 = blr

_fixit:
	li r12, 0
	subf r3, r13, r4 ; r13 = equipment count, r4 = all item count, r3 = material count
	li r8, 4
	subf r8, r13, r8
	cmpw r3, r8 ; slots 0 to 4-r13 are used by equipment
	;cmpwi r3, 4 ; only the 5 last slots are good
	;cmpwi r3, 3 ; only the 4 last slots are good (1 used by equipment)
	;cmpwi r3, 2 ; only the 3 last slots are good (2 used by equipment)
	;cmpwi r3, 1 ; only the 2 last slots are good (3 used by equipment)
	blelr
	li r3, 6 ; 0 equ: rand 0 to 4+1 (+1 for chances: 4/5 = 80%)
	;li r3, 5 ; 1 equ: rand 0 to 3+2 (chances: 3/5 = 60%)
	;li r3, 5 ; 2 equ: rand 0 to 2+2 (chances: )
	mflr r31
	lis r8, _mtRand@ha
	addi r8, r8, _mtRand@l
	mtctr r8
	bctrl
	mtlr r31
	add r3, r3, r13 ; 0+r13 to 4
	cmpwi r3, 4 ; r13 to 4 are the possible slots, others are ignored
	bgtlr
	mr r4, r3
	blr

0x021AF620 = bla _fixit
