[XCX_OFFLINEWE]
moduleMatches = 0xF882D5CF, 0x30B6E091 ; 1.0.1E, 1.0.2U

.origin = codecave

; getServerTimeSec__Q2_2nt10CNetLibNexCFRUL
;0x0295EA10 = nop
;0x0295EA14 = li r0, 1
;_getLocalTimeSec = 0x02892000
;0x0295EAA4 = bl _getLocalTimeSec

;0x0295EA7C = lis r3, 0xFFFF ; 008a43cd
;0x0295EA80 = ori r29, r3, 0xfff4
;0x0295EA84 = lis r4, 0 ; 2f060970
;0x0295EA88 = ori r30, r4, 8
;0x0295EA94 = lis r3, 0xffff ; 008a43cd
;0x0295EA94 = lis r4, 0xffff ; 2f060970
;0x0295EA98 = ori r4, r4, 0xfed4
;0x0295EAA4 = nop
; 65535
; 
;0x0295EA98 = lis r3, 0 ; 008a43cd
;0x0295EA9C = ori r3, r3, 0
;0x0295EAA0 = lis r4, 0x255B ; 2f060970
;0x0295EAA4 = ori r4, r4, 0x6100

; OSGetSystemInfo - 0(r3) 0ed1b768 > 248625000
;0x0295EA90 = li r8, 0

;0x022CA3E0 = nop
;0x022CA3E8 = nop

; cfs::CfSocialManager::update((float))
0x022879D0 = nop ; (network test?) allow call to cfs::CfSocialQuestManager::update((void))

; Autoriser accès aux missions d'escouade depuis la console réseau
0x02AC5C10 = li r3, 0 ; menu::CTerminalMenu_SquadQuest::offline

; cfs::CfSocialManager::refreshOrderQuestInfo (called when select an entry in the network console)
0x022C805C = nop ; network test : lwz       r10, 0x1B0(r30) --> rlwinm.   r9, r10, 0,30,30
0x022C8060 = nop ; network test

; collectQuestInfoWE__Q2_3cfs15CfSocialManagerFRQ2_2ml45resvector__tm__28_PQ2_3cfs17CfSocialQuestInfo
0x022C6254 = li r3, 1 ; fw::SocialDataStore::getWorldEnemyCount(const(void))
0x022C6280 = li r3, 0x4EE9 ; Quest ID for WE - fw::SocialDataStore::getWorldEnemyQuest(const(unsigned int))
0x022C65A8 = li r3, 1 ; fw::SocialDataStore::getWorldEnemyCount(const(void))

; collectQuestInfoFR__Q2_3cfs15CfSocialManagerFRQ2_2ml45resvector__tm__28_PQ2_3cfs17CfSocialQuestInfo
0x022C66CC = li r3, 1 ; fw::SocialDataStore::getWorldEnemyCount(const(void))
0x022C66FC = li r3, 0x4EED
0x022C6738 = nop ; network test?
0x022C6A5C = li r3, 1 ; fw::SocialDataStore::getWorldEnemyCount(const(void))


; refreshWorldEnemyFinalResult is the key ?!
;0x022862C4 = lis       r0, dword_10367630@h
;0x02AC48EC = stw       r4, dword_10367630@l(r7) ; menu::MenuBladeHomeTerminal::initialize((void)) 0x02AC458C
;0x02BA0D38 = stw       r0, dword_10367630@l(r30) ; menu::MenuMultiQuestResult::updateEnemyBoss((menu::MenuObject *))
;0x02BA0DC4 = stw       r11, dword_10367630@l(r30) ; menu::MenuMultiQuestResult::updateEnemyBoss((menu::MenuObject *))
;updateEnemyBoss = 0x02BA0B64
0x022863A4 = nop ; or.       r0, r6, r7
0x022863CC = nop ; or.       r0, r6, r7
; 0x02AC458C : OK
; 0x02AC48EC : KO
; 0x02BA0B64 : OK
; 0x0228637C : OK
0x02286474 = li r7, 1 ; for getWERewardList
; 0x02286774 : OK
;0x022868d8 = li r7, 1
;0x02286904 = li r7, 1
;0x02286BF0 = li r5, 2
;0x02286C38 = nop
; addWorldEnemyReward__Q2_3cfs15CfSocialManagerFRQ2_2ml41reslist__tm__26_Q2_3cfs16WorldEnemyRewardUiN32
; 0x02285F4C
;0x02285F60 = nop

; menu::QuestMgr::move((void)) 

; Manage RPs & Appraisal
VarShareRP:
.int 0
;_shareAP = reloc(0x1039C174)
VarShareAP:
.int 0

_loadRP:
;lis       r11, VarShareRP@ha
;lwz       r12, VarShareRP@l(r11)
;cmpwi     r12, 0
;bgt	   .+0xC
lis       r12, 0x0022
ori       r12, r12, 0x5510
;stw       r12, VarShareRP@l(r11)
;stw       r12, 0xC(r26)
blr
0x0282B2F0 = bla _loadRP ; __CPR86__getWorldEnemyInfo__Q2_2fw15SocialDataStoreCFUiRQ3_2fwJ25J14WorldEnemyInfo
;0x0282B2F0 = li        r12, 0x2A45

_updateRP:
;nop;mr		r30, r3 ; li 	r0, 0
stw	r11, 0x494(r27) ; lwz	r5, 0x3B8(r26) ; 
lis	r3, VarShareRP@ha ; lis	r30, _shareRP@ha
lwz	r9, VarShareRP@l(r3) ; lwz	r4, _shareRP@l(r30)
subf	r9, r11, r9 ; cmplw  r3, r5 ; 
stw	r9, VarShareRP@l(r3) ; beqlr ; stw	r4, _shareRP@l(r30)
lis	r3, VarShareAP@ha ; stw	r5, _shareRP@l(r4) ; lwz	r4, 0x498(r27)
lwz	r9, VarShareAP@l(r3) ; lis	r30, _shareAP@ha
add	r9, r11, r9 ; stw	r4, _shareAP@l(r30)
stw	r9, VarShareAP@l(r3) ; stw r28, 0xA8(r1) ; 
blr
;0x02BA0CE0 = bla _updateRP ; menu::MenuMultiQuestResult::updateEnemyBoss((menu::MenuObject *))

;0x1039C174 = .int 10
_loadAP:
lis       r8, VarShareAP@ha
lwz       r8, VarShareAP@l(r8)
blr
;0x0282B408 = bla _loadAP ; __CPR86__getWorldEnemyInfo__Q2_2fw15SocialDataStoreCFUiRQ3_2fwJ25J14WorldEnemyInfo

; ######################################### TODO : get WERewardList (Telethia Stem Cell)

; cfs::CfSocialManager::getQuestDetailWE((cfs::CfSocialQuestInfoWE &))
; |- __CPR95__getWorldEnemyInfoFromQuest__Q2_2fw15SocialDataStoreCFUiRQ3_2fwJ34J14WorldEnemyInfo
0x0282B454 = li r3, 0 ; getWorldEnemyIndexFromQuestID / Uncomment to show Appraisal Rewards
; |- |- __CPR86__getWorldEnemyInfo__Q2_2fw15SocialDataStoreCFUiRQ3_2fwJ25J14WorldEnemyInfo
0x0282B0E4 = li r7, 1 ; cmpwi     r7, 0
0x0282B0FC = li r0, 1 ; cmpwi     r0, 0
0x0282B170 = li r6, 1 ; to store in 8(r26) -> needed for cmpwi r0, 1 after callback
0x0282B264 = nop ; skip deserializeWorldEnemy
0x0282B410 = li r4, 1 ; for getWERewardList
;0x0281E680 = nop
;0x0281E6B0 = nop
;0x0281E6D8 = li r31, 0x06A3 ; enemyID (06A1 = Telethia, 06A3 = Yggdralith)

; cfs::CfSocialManager::getQuestDetailFR((cfs::CfSocialQuestInfoFR &))
0x0228989C = nop ; Uncomment to show Appraisal Rewards

; Abandonned (1)
;022C9F30: r4 = 1
;022CA188: r12 = 1
;022CA1F8: getBoxNum = 0
;r6 = 1
;022CA280: r0 = 0

; Complete (3)
;022CA1F8: getBoxNum = 1
;022C9F5C: r6 = 0
;022CA114: r8 = 1

;0x02CFD37C = li r3, 2 ; only common

;0x022CA280 = cmpw r0, r0 ; never common items
;0x022CA284 = nop ; always common items

;0x022CA1F4 = li r3, 1 ; getBoxNum - always beaten items ?

; A droite les items communs
; A gauche les items si Nemesis battu

[XCX_OFFLINEWE_1E] ############################################################################################
moduleMatches = 0xF882D5CF ; 1.0.1E

.origin = codecave

; menu::MenuMultiQuestOrder::move((void))
; skip BLADE medals requirement on launch mission
0x02B9B0B0 = li r3, 1 ; Disable call to menu::MenuMultiQuestOrder::canOrderWorldEnemy

;02B9A200 ; getMultiQuestList
;02B9A20C 
	; menu::MenuMultiQuestOrder::setup
	;0x02B9A498 = nop CRASH
	; menu::MenuMultiQuestOrder::setupTicket
	;0x02B9A4CC = nop
	; menu::QuestMgr::getWorldEnemyTicket(const(void))
;0x02CFE140 = li r3, 2
;02B9A210
; menu::QuestMgr::hasWEResult(const(void))
;0x02CFE200 = li r3, 0
;02B9A214

; menu::CTerminalMenu_PieceExchange::offline((void))
; Allow access to piece exchange from network console
_single:
li r3, 0
blr
0x02AC613C = ba _single ; menu::CBladeHomuMenu::single((void))

; __CPR129__getMultiQuestReward__Q2_3cfs15CfSocialManagerCFUiRQ2_3mtl68fixed_vector__tm__48_Q3_3cfsJ28J11QuestRewardXCUiL_2_46T1 --> OK
; 0x022C9E88
0x022CA324 = nop ; always all items?

; menu::MenuMultiQuestInfoSub::displayInfoWE((menu::MenuObject *))
;0x02B90A6C = nop ; CRASH
;_doit = 0x02B90F14
;0x02B90A6C = b _doit
; RP remaining = 0x3B8(r26=r3=CfSocialQuestInfo)
; |- r3 = 0x478(r29=r3=MenuMultiQuestInfoSub)
; |- RP from 0x1C(r1)
; Appraisal = 0x3BC(r26)
; 0xC(r5) CfSocialQuestInfo::collectQuestInfoWE => 0xC(r26) __CPR86__getWorldEnemyInfo__Q2_2fw15SocialDataStoreCFUiRQ3_2fwJ25J14WorldEnemyInfo
;0x02B91D80 = blr ; displayInfo - juste le cadre est visible
;0x02B917EC = blr ; displayInfoAward - aucun effet
;0x02B90814 = blr ; MenuMultiQuestInfoSub::displayInfoWE - fenêtre avec squelette mais aucune valeur
;0x02B9F30C = blr ; MenuMultiQuestResult::setup - Valeur et descriptif OK, titre vide
;0x02B9F07C = blr ; MenuMultiQuestResult::updateList - NON
;0x02BA0A64 = blr ; MenuMultiQuestResult::setupEnemyBoss - Valeur et titre OK, descriptif vide
;0x02BA1068 = blr ; MenuMultiQuestResult::displayInfo - NON
; move
;0x02BA1818 = nop ; crash (r3=1bcd3870)
;0x02BA1A80 = nop ; updateTimeAttack__Q2_4menu20MenuMultiQuestResultFPQ2_4menu10MenuObject crash ?
;0x02BA21B4 = nop ; updateEnemyBoss__Q2_4menu20MenuMultiQuestResultFPQ2_4menu10MenuObject crash ?

; load 5ae0
; 1bcd38d0
;0x02BA1AD8
;0x02BA20B0 - ok
;0x02BA20E0
;0x02b90a80 - displayInfoWE
;0x2b90ac0
;0x02BA20B0 = li r3, 0

; menu::MenuMultiQuestResult::updateEnemyBoss((menu::MenuObject *))
; tout fini loc_2BA0D8C
; 0x494(r27) = RP stolen (from 0x5770)
; 0x498(r27) = ?
; 0x46C(r27) = appraisal ?
; 0x5770(r27) = Total RP stolen !
; 0x470(r26) = RP stolen ?

;0x02B90A80 = li r5, 51 ; 0x3B8
;0x02B90AC0 = li r5, 42 ; 0x3BC
;0x02B90B04 = li r8, 1 ; 0x470
;0x02B90B34 = li r6, 42
;0x02B90EB8 = li r9, 1 ; 0x3C8(r26)
;0x02B90EC8 = li r10, 2 ; 0x3CC(r26)
;0x02B90EE8 = li r9, 1 ; 0x3C8(r26)
;0x02B90EF8 = li r10, 2 ; 0x3CC(r26)

; menu::MenuMultiQuestOrder::move((void))
;02B9A1F8 > 02B9D020
;02B9A204 > 02B9A3B0
;02B9A208 > 02B9A3C4
;02B9A228 > 02B9B40C openWEFinalResult
;02B9A22C (loop) > 02B9B45C isFinishWEFinalResult
;02B9A20C > 02B9A3E8 setup
;02B9A210 (disp) > 
;02B9A214 (loop) > 

; menu::QuestMgr::hasWEResult(const(void))
;0x02CFE200 = li r3, 1

; menu::QuestMgr::checkWEResult((void)) LOOP

; menu::MenuWEFinalResult::move((void))
;02C23468
;02C2346C
;02C23470 > 02C235F8 requestWEResult
;02C23474 > 02C23658 getWEResultState (=2) & getWEResultInfo
;02C2352C
;02C23530
;02C23520
;02C23524
;02C23528
;02C23530

[XCX_OFFLINEWE_2U] ############################################################################################
moduleMatches = 0x30B6E091 ; 1.0.2U

.origin = codecave

;0x02B9B0A0 = li r3, 1 ; Disable call to menu::MenuMultiQuestOrder::canOrderWorldEnemy

_single:
li r3, 0
blr

0x02AC612C = ba _single

[XCX_OFFLINEWE_1U] ############################################################################################
moduleMatches = 0xAB97DE6B ; 1.0.1U

.origin = codecave

0x02287960 = nop ; (network test?) allow call to cfs::CfSocialQuestManager::update((void))
0x02AC5B84 = li r3, 0 ; menu::CTerminalMenu_SquadQuest::offline
0x022C7FEC = nop ; network test : lwz       r10, 0x1B0(r30) --> rlwinm.   r9, r10, 0,30,30
0x022C7FF0 = nop ; network test
0x022C61E4 = li r3, 1 ; fw::SocialDataStore::getWorldEnemyCount(const(void))
0x022C6210 = li r3, 0x4EE9 ; Quest ID for WE - fw::SocialDataStore::getWorldEnemyQuest(const(unsigned int))
0x022C6538 = li r3, 1 ; fw::SocialDataStore::getWorldEnemyCount(const(void))
0x022C668C = li r3, 1 ; fw::SocialDataStore::getWorldEnemyCount(const(void))
0x022C668C = li r3, 0x4EED
0x022C66C8 = nop ; network test?
0x022C69EC = li r3, 1 ; fw::SocialDataStore::getWorldEnemyCount(const(void))
0x022863A4 = nop ; or.       r0, r6, r7
0x022863CC = nop ; or.       r0, r6, r7
0x02286474 = li r7, 1 ; for getWERewardList

_loadRP:
lis       r12, 0x0022
ori       r12, r12, 0x5510
blr
0x0282B274 = bla _loadRP ; __CPR86__getWorldEnemyInfo__Q2_2fw15SocialDataStoreCFUiRQ3_2fwJ25J14WorldEnemyInfo

0x0282B3D8 = li r3, 0 ; getWorldEnemyIndexFromQuestID / Uncomment to show Appraisal Rewards
0x0282B068 = li r7, 1 ; cmpwi     r7, 0
0x0282B080 = li r0, 1 ; cmpwi     r0, 0
0x0282B0F4 = li r6, 1 ; to store in 8(r26) -> needed for cmpwi r0, 1 after callback
0x0282B1E8 = nop ; skip deserializeWorldEnemy
0x0282B394 = li r4, 1 ; for getWERewardList
0x0228982C = nop ; Uncomment to show Appraisal Rewards
0x02B9AFB0 = li r3, 1 ; Disable call to menu::MenuMultiQuestOrder::canOrderWorldEnemy

_single:
li r3, 0
blr
0x02AC60B0 = ba _single ; menu::CBladeHomuMenu::single((void))

0x022CA2B4 = nop ; always all items?
