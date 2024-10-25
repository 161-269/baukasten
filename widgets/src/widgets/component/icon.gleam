import gleam/dynamic.{type DecodeError, type Dynamic, DecodeError}
import gleam/json.{type Json}
import gleam/option.{Some}
import gleam/result
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import widgets/component/component_interface.{type InnerNode, LeafNode}
import widgets/tailwind/class/typography.{
  type FontFamily, type FontSize, type FontStyle, type FontWeight,
  type TextDecoration,
} as _
import widgets/tailwind/component/typography.{type Typography, Typography}

pub type IconType {
  Num0Circle
  Num0CircleFill
  Num0Square
  Num0SquareFill
  Num1Circle
  Num1CircleFill
  Num1Square
  Num1SquareFill
  Num123
  Num2Circle
  Num2CircleFill
  Num2Square
  Num2SquareFill
  Num3Circle
  Num3CircleFill
  Num3Square
  Num3SquareFill
  Num4Circle
  Num4CircleFill
  Num4Square
  Num4SquareFill
  Num5Circle
  Num5CircleFill
  Num5Square
  Num5SquareFill
  Num6Circle
  Num6CircleFill
  Num6Square
  Num6SquareFill
  Num7Circle
  Num7CircleFill
  Num7Square
  Num7SquareFill
  Num8Circle
  Num8CircleFill
  Num8Square
  Num8SquareFill
  Num9Circle
  Num9CircleFill
  Num9Square
  Num9SquareFill
  Activity
  Airplane
  AirplaneEngines
  AirplaneEnginesFill
  AirplaneFill
  Alarm
  AlarmFill
  Alexa
  AlignBottom
  AlignCenter
  AlignEnd
  AlignMiddle
  AlignStart
  AlignTop
  Alipay
  Alphabet
  AlphabetUppercase
  Alt
  Amazon
  Amd
  Android
  Android2
  App
  AppIndicator
  Apple
  Archive
  ArchiveFill
  Arrow90degDown
  Arrow90degLeft
  Arrow90degRight
  Arrow90degUp
  ArrowBarDown
  ArrowBarLeft
  ArrowBarRight
  ArrowBarUp
  ArrowClockwise
  ArrowCounterclockwise
  ArrowDown
  ArrowDownCircle
  ArrowDownCircleFill
  ArrowDownLeft
  ArrowDownLeftCircle
  ArrowDownLeftCircleFill
  ArrowDownLeftSquare
  ArrowDownLeftSquareFill
  ArrowDownRight
  ArrowDownRightCircle
  ArrowDownRightCircleFill
  ArrowDownRightSquare
  ArrowDownRightSquareFill
  ArrowDownShort
  ArrowDownSquare
  ArrowDownSquareFill
  ArrowDownUp
  ArrowLeft
  ArrowLeftCircle
  ArrowLeftCircleFill
  ArrowLeftRight
  ArrowLeftShort
  ArrowLeftSquare
  ArrowLeftSquareFill
  ArrowRepeat
  ArrowReturnLeft
  ArrowReturnRight
  ArrowRight
  ArrowRightCircle
  ArrowRightCircleFill
  ArrowRightShort
  ArrowRightSquare
  ArrowRightSquareFill
  ArrowThroughHeart
  ArrowThroughHeartFill
  ArrowUp
  ArrowUpCircle
  ArrowUpCircleFill
  ArrowUpLeft
  ArrowUpLeftCircle
  ArrowUpLeftCircleFill
  ArrowUpLeftSquare
  ArrowUpLeftSquareFill
  ArrowUpRight
  ArrowUpRightCircle
  ArrowUpRightCircleFill
  ArrowUpRightSquare
  ArrowUpRightSquareFill
  ArrowUpShort
  ArrowUpSquare
  ArrowUpSquareFill
  Arrows
  ArrowsAngleContract
  ArrowsAngleExpand
  ArrowsCollapse
  ArrowsCollapseVertical
  ArrowsExpand
  ArrowsExpandVertical
  ArrowsFullscreen
  ArrowsMove
  ArrowsVertical
  AspectRatio
  AspectRatioFill
  Asterisk
  At
  Award
  AwardFill
  Back
  Backpack
  BackpackFill
  Backpack2
  Backpack2Fill
  Backpack3
  Backpack3Fill
  Backpack4
  Backpack4Fill
  Backspace
  BackspaceFill
  BackspaceReverse
  BackspaceReverseFill
  Badge3d
  Badge3dFill
  Badge4k
  Badge4kFill
  Badge8k
  Badge8kFill
  BadgeAd
  BadgeAdFill
  BadgeAr
  BadgeArFill
  BadgeCc
  BadgeCcFill
  BadgeHd
  BadgeHdFill
  BadgeSd
  BadgeSdFill
  BadgeTm
  BadgeTmFill
  BadgeVo
  BadgeVoFill
  BadgeVr
  BadgeVrFill
  BadgeWc
  BadgeWcFill
  Bag
  BagCheck
  BagCheckFill
  BagDash
  BagDashFill
  BagFill
  BagHeart
  BagHeartFill
  BagPlus
  BagPlusFill
  BagX
  BagXFill
  Balloon
  BalloonFill
  BalloonHeart
  BalloonHeartFill
  Ban
  BanFill
  Bandaid
  BandaidFill
  Bank
  Bank2
  BarChart
  BarChartFill
  BarChartLine
  BarChartLineFill
  BarChartSteps
  Basket
  BasketFill
  Basket2
  Basket2Fill
  Basket3
  Basket3Fill
  Battery
  BatteryCharging
  BatteryFull
  BatteryHalf
  Behance
  Bell
  BellFill
  BellSlash
  BellSlashFill
  Bezier
  Bezier2
  Bicycle
  Bing
  Binoculars
  BinocularsFill
  BlockquoteLeft
  BlockquoteRight
  Bluetooth
  BodyText
  Book
  BookFill
  BookHalf
  Bookmark
  BookmarkCheck
  BookmarkCheckFill
  BookmarkDash
  BookmarkDashFill
  BookmarkFill
  BookmarkHeart
  BookmarkHeartFill
  BookmarkPlus
  BookmarkPlusFill
  BookmarkStar
  BookmarkStarFill
  BookmarkX
  BookmarkXFill
  Bookmarks
  BookmarksFill
  Bookshelf
  Boombox
  BoomboxFill
  Bootstrap
  BootstrapFill
  BootstrapReboot
  Border
  BorderAll
  BorderBottom
  BorderCenter
  BorderInner
  BorderLeft
  BorderMiddle
  BorderOuter
  BorderRight
  BorderStyle
  BorderTop
  BorderWidth
  BoundingBox
  BoundingBoxCircles
  Box
  BoxArrowDown
  BoxArrowDownLeft
  BoxArrowDownRight
  BoxArrowInDown
  BoxArrowInDownLeft
  BoxArrowInDownRight
  BoxArrowInLeft
  BoxArrowInRight
  BoxArrowInUp
  BoxArrowInUpLeft
  BoxArrowInUpRight
  BoxArrowLeft
  BoxArrowRight
  BoxArrowUp
  BoxArrowUpLeft
  BoxArrowUpRight
  BoxFill
  BoxSeam
  BoxSeamFill
  Box2
  Box2Fill
  Box2Heart
  Box2HeartFill
  Boxes
  Braces
  BracesAsterisk
  Bricks
  Briefcase
  BriefcaseFill
  BrightnessAltHigh
  BrightnessAltHighFill
  BrightnessAltLow
  BrightnessAltLowFill
  BrightnessHigh
  BrightnessHighFill
  BrightnessLow
  BrightnessLowFill
  Brilliance
  Broadcast
  BroadcastPin
  BrowserChrome
  BrowserEdge
  BrowserFirefox
  BrowserSafari
  Brush
  BrushFill
  Bucket
  BucketFill
  Bug
  BugFill
  Building
  BuildingAdd
  BuildingCheck
  BuildingDash
  BuildingDown
  BuildingExclamation
  BuildingFill
  BuildingFillAdd
  BuildingFillCheck
  BuildingFillDash
  BuildingFillDown
  BuildingFillExclamation
  BuildingFillGear
  BuildingFillLock
  BuildingFillSlash
  BuildingFillUp
  BuildingFillX
  BuildingGear
  BuildingLock
  BuildingSlash
  BuildingUp
  BuildingX
  Buildings
  BuildingsFill
  Bullseye
  BusFront
  BusFrontFill
  CCircle
  CCircleFill
  CSquare
  CSquareFill
  Cake
  CakeFill
  Cake2
  Cake2Fill
  Calculator
  CalculatorFill
  Calendar
  CalendarCheck
  CalendarCheckFill
  CalendarDate
  CalendarDateFill
  CalendarDay
  CalendarDayFill
  CalendarEvent
  CalendarEventFill
  CalendarFill
  CalendarHeart
  CalendarHeartFill
  CalendarMinus
  CalendarMinusFill
  CalendarMonth
  CalendarMonthFill
  CalendarPlus
  CalendarPlusFill
  CalendarRange
  CalendarRangeFill
  CalendarWeek
  CalendarWeekFill
  CalendarX
  CalendarXFill
  Calendar2
  Calendar2Check
  Calendar2CheckFill
  Calendar2Date
  Calendar2DateFill
  Calendar2Day
  Calendar2DayFill
  Calendar2Event
  Calendar2EventFill
  Calendar2Fill
  Calendar2Heart
  Calendar2HeartFill
  Calendar2Minus
  Calendar2MinusFill
  Calendar2Month
  Calendar2MonthFill
  Calendar2Plus
  Calendar2PlusFill
  Calendar2Range
  Calendar2RangeFill
  Calendar2Week
  Calendar2WeekFill
  Calendar2X
  Calendar2XFill
  Calendar3
  Calendar3Event
  Calendar3EventFill
  Calendar3Fill
  Calendar3Range
  Calendar3RangeFill
  Calendar3Week
  Calendar3WeekFill
  Calendar4
  Calendar4Event
  Calendar4Range
  Calendar4Week
  Camera
  CameraFill
  CameraReels
  CameraReelsFill
  CameraVideo
  CameraVideoFill
  CameraVideoOff
  CameraVideoOffFill
  Camera2
  Capslock
  CapslockFill
  Capsule
  CapsulePill
  CarFront
  CarFrontFill
  CardChecklist
  CardHeading
  CardImage
  CardList
  CardText
  CaretDown
  CaretDownFill
  CaretDownSquare
  CaretDownSquareFill
  CaretLeft
  CaretLeftFill
  CaretLeftSquare
  CaretLeftSquareFill
  CaretRight
  CaretRightFill
  CaretRightSquare
  CaretRightSquareFill
  CaretUp
  CaretUpFill
  CaretUpSquare
  CaretUpSquareFill
  Cart
  CartCheck
  CartCheckFill
  CartDash
  CartDashFill
  CartFill
  CartPlus
  CartPlusFill
  CartX
  CartXFill
  Cart2
  Cart3
  Cart4
  Cash
  CashCoin
  CashStack
  Cassette
  CassetteFill
  Cast
  CcCircle
  CcCircleFill
  CcSquare
  CcSquareFill
  Chat
  ChatDots
  ChatDotsFill
  ChatFill
  ChatHeart
  ChatHeartFill
  ChatLeft
  ChatLeftDots
  ChatLeftDotsFill
  ChatLeftFill
  ChatLeftHeart
  ChatLeftHeartFill
  ChatLeftQuote
  ChatLeftQuoteFill
  ChatLeftText
  ChatLeftTextFill
  ChatQuote
  ChatQuoteFill
  ChatRight
  ChatRightDots
  ChatRightDotsFill
  ChatRightFill
  ChatRightHeart
  ChatRightHeartFill
  ChatRightQuote
  ChatRightQuoteFill
  ChatRightText
  ChatRightTextFill
  ChatSquare
  ChatSquareDots
  ChatSquareDotsFill
  ChatSquareFill
  ChatSquareHeart
  ChatSquareHeartFill
  ChatSquareQuote
  ChatSquareQuoteFill
  ChatSquareText
  ChatSquareTextFill
  ChatText
  ChatTextFill
  Check
  CheckAll
  CheckCircle
  CheckCircleFill
  CheckLg
  CheckSquare
  CheckSquareFill
  Check2
  Check2All
  Check2Circle
  Check2Square
  ChevronBarContract
  ChevronBarDown
  ChevronBarExpand
  ChevronBarLeft
  ChevronBarRight
  ChevronBarUp
  ChevronCompactDown
  ChevronCompactLeft
  ChevronCompactRight
  ChevronCompactUp
  ChevronContract
  ChevronDoubleDown
  ChevronDoubleLeft
  ChevronDoubleRight
  ChevronDoubleUp
  ChevronDown
  ChevronExpand
  ChevronLeft
  ChevronRight
  ChevronUp
  Circle
  CircleFill
  CircleHalf
  CircleSquare
  Clipboard
  ClipboardCheck
  ClipboardCheckFill
  ClipboardData
  ClipboardDataFill
  ClipboardFill
  ClipboardHeart
  ClipboardHeartFill
  ClipboardMinus
  ClipboardMinusFill
  ClipboardPlus
  ClipboardPlusFill
  ClipboardPulse
  ClipboardX
  ClipboardXFill
  Clipboard2
  Clipboard2Check
  Clipboard2CheckFill
  Clipboard2Data
  Clipboard2DataFill
  Clipboard2Fill
  Clipboard2Heart
  Clipboard2HeartFill
  Clipboard2Minus
  Clipboard2MinusFill
  Clipboard2Plus
  Clipboard2PlusFill
  Clipboard2Pulse
  Clipboard2PulseFill
  Clipboard2X
  Clipboard2XFill
  Clock
  ClockFill
  ClockHistory
  Cloud
  CloudArrowDown
  CloudArrowDownFill
  CloudArrowUp
  CloudArrowUpFill
  CloudCheck
  CloudCheckFill
  CloudDownload
  CloudDownloadFill
  CloudDrizzle
  CloudDrizzleFill
  CloudFill
  CloudFog
  CloudFogFill
  CloudFog2
  CloudFog2Fill
  CloudHail
  CloudHailFill
  CloudHaze
  CloudHazeFill
  CloudHaze2
  CloudHaze2Fill
  CloudLightning
  CloudLightningFill
  CloudLightningRain
  CloudLightningRainFill
  CloudMinus
  CloudMinusFill
  CloudMoon
  CloudMoonFill
  CloudPlus
  CloudPlusFill
  CloudRain
  CloudRainFill
  CloudRainHeavy
  CloudRainHeavyFill
  CloudSlash
  CloudSlashFill
  CloudSleet
  CloudSleetFill
  CloudSnow
  CloudSnowFill
  CloudSun
  CloudSunFill
  CloudUpload
  CloudUploadFill
  Clouds
  CloudsFill
  Cloudy
  CloudyFill
  Code
  CodeSlash
  CodeSquare
  Coin
  Collection
  CollectionFill
  CollectionPlay
  CollectionPlayFill
  Columns
  ColumnsGap
  Command
  Compass
  CompassFill
  Cone
  ConeStriped
  Controller
  Cookie
  Copy
  Cpu
  CpuFill
  CreditCard
  CreditCard2Back
  CreditCard2BackFill
  CreditCard2Front
  CreditCard2FrontFill
  CreditCardFill
  Crop
  Crosshair
  Crosshair2
  Cup
  CupFill
  CupHot
  CupHotFill
  CupStraw
  CurrencyBitcoin
  CurrencyDollar
  CurrencyEuro
  CurrencyExchange
  CurrencyPound
  CurrencyRupee
  CurrencyYen
  Cursor
  CursorFill
  CursorText
  Dash
  DashCircle
  DashCircleDotted
  DashCircleFill
  DashLg
  DashSquare
  DashSquareDotted
  DashSquareFill
  Database
  DatabaseAdd
  DatabaseCheck
  DatabaseDash
  DatabaseDown
  DatabaseExclamation
  DatabaseFill
  DatabaseFillAdd
  DatabaseFillCheck
  DatabaseFillDash
  DatabaseFillDown
  DatabaseFillExclamation
  DatabaseFillGear
  DatabaseFillLock
  DatabaseFillSlash
  DatabaseFillUp
  DatabaseFillX
  DatabaseGear
  DatabaseLock
  DatabaseSlash
  DatabaseUp
  DatabaseX
  DeviceHdd
  DeviceHddFill
  DeviceSsd
  DeviceSsdFill
  Diagram2
  Diagram2Fill
  Diagram3
  Diagram3Fill
  Diamond
  DiamondFill
  DiamondHalf
  Dice1
  Dice1Fill
  Dice2
  Dice2Fill
  Dice3
  Dice3Fill
  Dice4
  Dice4Fill
  Dice5
  Dice5Fill
  Dice6
  Dice6Fill
  Disc
  DiscFill
  Discord
  Display
  DisplayFill
  Displayport
  DisplayportFill
  DistributeHorizontal
  DistributeVertical
  DoorClosed
  DoorClosedFill
  DoorOpen
  DoorOpenFill
  Dot
  Download
  Dpad
  DpadFill
  Dribbble
  Dropbox
  Droplet
  DropletFill
  DropletHalf
  Duffle
  DuffleFill
  Ear
  EarFill
  Earbuds
  Easel
  EaselFill
  Easel2
  Easel2Fill
  Easel3
  Easel3Fill
  Egg
  EggFill
  EggFried
  Eject
  EjectFill
  EmojiAngry
  EmojiAngryFill
  EmojiAstonished
  EmojiAstonishedFill
  EmojiDizzy
  EmojiDizzyFill
  EmojiExpressionless
  EmojiExpressionlessFill
  EmojiFrown
  EmojiFrownFill
  EmojiGrimace
  EmojiGrimaceFill
  EmojiGrin
  EmojiGrinFill
  EmojiHeartEyes
  EmojiHeartEyesFill
  EmojiKiss
  EmojiKissFill
  EmojiLaughing
  EmojiLaughingFill
  EmojiNeutral
  EmojiNeutralFill
  EmojiSmile
  EmojiSmileFill
  EmojiSmileUpsideDown
  EmojiSmileUpsideDownFill
  EmojiSunglasses
  EmojiSunglassesFill
  EmojiSurprise
  EmojiSurpriseFill
  EmojiTear
  EmojiTearFill
  EmojiWink
  EmojiWinkFill
  Envelope
  EnvelopeArrowDown
  EnvelopeArrowDownFill
  EnvelopeArrowUp
  EnvelopeArrowUpFill
  EnvelopeAt
  EnvelopeAtFill
  EnvelopeCheck
  EnvelopeCheckFill
  EnvelopeDash
  EnvelopeDashFill
  EnvelopeExclamation
  EnvelopeExclamationFill
  EnvelopeFill
  EnvelopeHeart
  EnvelopeHeartFill
  EnvelopeOpen
  EnvelopeOpenFill
  EnvelopeOpenHeart
  EnvelopeOpenHeartFill
  EnvelopePaper
  EnvelopePaperFill
  EnvelopePaperHeart
  EnvelopePaperHeartFill
  EnvelopePlus
  EnvelopePlusFill
  EnvelopeSlash
  EnvelopeSlashFill
  EnvelopeX
  EnvelopeXFill
  Eraser
  EraserFill
  Escape
  Ethernet
  EvFront
  EvFrontFill
  EvStation
  EvStationFill
  Exclamation
  ExclamationCircle
  ExclamationCircleFill
  ExclamationDiamond
  ExclamationDiamondFill
  ExclamationLg
  ExclamationOctagon
  ExclamationOctagonFill
  ExclamationSquare
  ExclamationSquareFill
  ExclamationTriangle
  ExclamationTriangleFill
  Exclude
  Explicit
  ExplicitFill
  Exposure
  Eye
  EyeFill
  EyeSlash
  EyeSlashFill
  Eyedropper
  Eyeglasses
  Facebook
  Fan
  FastForward
  FastForwardBtn
  FastForwardBtnFill
  FastForwardCircle
  FastForwardCircleFill
  FastForwardFill
  Feather
  Feather2
  File
  FileArrowDown
  FileArrowDownFill
  FileArrowUp
  FileArrowUpFill
  FileBarGraph
  FileBarGraphFill
  FileBinary
  FileBinaryFill
  FileBreak
  FileBreakFill
  FileCheck
  FileCheckFill
  FileCode
  FileCodeFill
  FileDiff
  FileDiffFill
  FileEarmark
  FileEarmarkArrowDown
  FileEarmarkArrowDownFill
  FileEarmarkArrowUp
  FileEarmarkArrowUpFill
  FileEarmarkBarGraph
  FileEarmarkBarGraphFill
  FileEarmarkBinary
  FileEarmarkBinaryFill
  FileEarmarkBreak
  FileEarmarkBreakFill
  FileEarmarkCheck
  FileEarmarkCheckFill
  FileEarmarkCode
  FileEarmarkCodeFill
  FileEarmarkDiff
  FileEarmarkDiffFill
  FileEarmarkEasel
  FileEarmarkEaselFill
  FileEarmarkExcel
  FileEarmarkExcelFill
  FileEarmarkFill
  FileEarmarkFont
  FileEarmarkFontFill
  FileEarmarkImage
  FileEarmarkImageFill
  FileEarmarkLock
  FileEarmarkLockFill
  FileEarmarkLock2
  FileEarmarkLock2Fill
  FileEarmarkMedical
  FileEarmarkMedicalFill
  FileEarmarkMinus
  FileEarmarkMinusFill
  FileEarmarkMusic
  FileEarmarkMusicFill
  FileEarmarkPdf
  FileEarmarkPdfFill
  FileEarmarkPerson
  FileEarmarkPersonFill
  FileEarmarkPlay
  FileEarmarkPlayFill
  FileEarmarkPlus
  FileEarmarkPlusFill
  FileEarmarkPost
  FileEarmarkPostFill
  FileEarmarkPpt
  FileEarmarkPptFill
  FileEarmarkRichtext
  FileEarmarkRichtextFill
  FileEarmarkRuled
  FileEarmarkRuledFill
  FileEarmarkSlides
  FileEarmarkSlidesFill
  FileEarmarkSpreadsheet
  FileEarmarkSpreadsheetFill
  FileEarmarkText
  FileEarmarkTextFill
  FileEarmarkWord
  FileEarmarkWordFill
  FileEarmarkX
  FileEarmarkXFill
  FileEarmarkZip
  FileEarmarkZipFill
  FileEasel
  FileEaselFill
  FileExcel
  FileExcelFill
  FileFill
  FileFont
  FileFontFill
  FileImage
  FileImageFill
  FileLock
  FileLockFill
  FileLock2
  FileLock2Fill
  FileMedical
  FileMedicalFill
  FileMinus
  FileMinusFill
  FileMusic
  FileMusicFill
  FilePdf
  FilePdfFill
  FilePerson
  FilePersonFill
  FilePlay
  FilePlayFill
  FilePlus
  FilePlusFill
  FilePost
  FilePostFill
  FilePpt
  FilePptFill
  FileRichtext
  FileRichtextFill
  FileRuled
  FileRuledFill
  FileSlides
  FileSlidesFill
  FileSpreadsheet
  FileSpreadsheetFill
  FileText
  FileTextFill
  FileWord
  FileWordFill
  FileX
  FileXFill
  FileZip
  FileZipFill
  Files
  FilesAlt
  FiletypeAac
  FiletypeAi
  FiletypeBmp
  FiletypeCs
  FiletypeCss
  FiletypeCsv
  FiletypeDoc
  FiletypeDocx
  FiletypeExe
  FiletypeGif
  FiletypeHeic
  FiletypeHtml
  FiletypeJava
  FiletypeJpg
  FiletypeJs
  FiletypeJson
  FiletypeJsx
  FiletypeKey
  FiletypeM4p
  FiletypeMd
  FiletypeMdx
  FiletypeMov
  FiletypeMp3
  FiletypeMp4
  FiletypeOtf
  FiletypePdf
  FiletypePhp
  FiletypePng
  FiletypePpt
  FiletypePptx
  FiletypePsd
  FiletypePy
  FiletypeRaw
  FiletypeRb
  FiletypeSass
  FiletypeScss
  FiletypeSh
  FiletypeSql
  FiletypeSvg
  FiletypeTiff
  FiletypeTsx
  FiletypeTtf
  FiletypeTxt
  FiletypeWav
  FiletypeWoff
  FiletypeXls
  FiletypeXlsx
  FiletypeXml
  FiletypeYml
  Film
  Filter
  FilterCircle
  FilterCircleFill
  FilterLeft
  FilterRight
  FilterSquare
  FilterSquareFill
  Fingerprint
  Fire
  Flag
  FlagFill
  Floppy
  FloppyFill
  Floppy2
  Floppy2Fill
  Flower1
  Flower2
  Flower3
  Folder
  FolderCheck
  FolderFill
  FolderMinus
  FolderPlus
  FolderSymlink
  FolderSymlinkFill
  FolderX
  Folder2
  Folder2Open
  Fonts
  Forward
  ForwardFill
  Front
  FuelPump
  FuelPumpDiesel
  FuelPumpDieselFill
  FuelPumpFill
  Fullscreen
  FullscreenExit
  Funnel
  FunnelFill
  Gear
  GearFill
  GearWide
  GearWideConnected
  Gem
  GenderAmbiguous
  GenderFemale
  GenderMale
  GenderNeuter
  GenderTrans
  Geo
  GeoAlt
  GeoAltFill
  GeoFill
  Gift
  GiftFill
  Git
  Github
  Gitlab
  Globe
  GlobeAmericas
  GlobeAsiaAustralia
  GlobeCentralSouthAsia
  GlobeEuropeAfrica
  Globe2
  Google
  GooglePlay
  GpuCard
  GraphDown
  GraphDownArrow
  GraphUp
  GraphUpArrow
  Grid
  Grid1x2
  Grid1x2Fill
  Grid3x2
  Grid3x2Gap
  Grid3x2GapFill
  Grid3x3
  Grid3x3Gap
  Grid3x3GapFill
  GridFill
  GripHorizontal
  GripVertical
  HCircle
  HCircleFill
  HSquare
  HSquareFill
  Hammer
  HandIndex
  HandIndexFill
  HandIndexThumb
  HandIndexThumbFill
  HandThumbsDown
  HandThumbsDownFill
  HandThumbsUp
  HandThumbsUpFill
  Handbag
  HandbagFill
  Hash
  Hdd
  HddFill
  HddNetwork
  HddNetworkFill
  HddRack
  HddRackFill
  HddStack
  HddStackFill
  Hdmi
  HdmiFill
  Headphones
  Headset
  HeadsetVr
  Heart
  HeartArrow
  HeartFill
  HeartHalf
  HeartPulse
  HeartPulseFill
  Heartbreak
  HeartbreakFill
  Hearts
  Heptagon
  HeptagonFill
  HeptagonHalf
  Hexagon
  HexagonFill
  HexagonHalf
  Highlighter
  Highlights
  Hospital
  HospitalFill
  Hourglass
  HourglassBottom
  HourglassSplit
  HourglassTop
  House
  HouseAdd
  HouseAddFill
  HouseCheck
  HouseCheckFill
  HouseDash
  HouseDashFill
  HouseDoor
  HouseDoorFill
  HouseDown
  HouseDownFill
  HouseExclamation
  HouseExclamationFill
  HouseFill
  HouseGear
  HouseGearFill
  HouseHeart
  HouseHeartFill
  HouseLock
  HouseLockFill
  HouseSlash
  HouseSlashFill
  HouseUp
  HouseUpFill
  HouseX
  HouseXFill
  Houses
  HousesFill
  Hr
  Hurricane
  Hypnotize
  Image
  ImageAlt
  ImageFill
  Images
  Inbox
  InboxFill
  Inboxes
  InboxesFill
  Incognito
  Indent
  Infinity
  Info
  InfoCircle
  InfoCircleFill
  InfoLg
  InfoSquare
  InfoSquareFill
  InputCursor
  InputCursorText
  Instagram
  Intersect
  Journal
  JournalAlbum
  JournalArrowDown
  JournalArrowUp
  JournalBookmark
  JournalBookmarkFill
  JournalCheck
  JournalCode
  JournalMedical
  JournalMinus
  JournalPlus
  JournalRichtext
  JournalText
  JournalX
  Journals
  Joystick
  Justify
  JustifyLeft
  JustifyRight
  Kanban
  KanbanFill
  Key
  KeyFill
  Keyboard
  KeyboardFill
  Ladder
  Lamp
  LampFill
  Laptop
  LaptopFill
  LayerBackward
  LayerForward
  Layers
  LayersFill
  LayersHalf
  LayoutSidebar
  LayoutSidebarInset
  LayoutSidebarInsetReverse
  LayoutSidebarReverse
  LayoutSplit
  LayoutTextSidebar
  LayoutTextSidebarReverse
  LayoutTextWindow
  LayoutTextWindowReverse
  LayoutThreeColumns
  LayoutWtf
  LifePreserver
  Lightbulb
  LightbulbFill
  LightbulbOff
  LightbulbOffFill
  Lightning
  LightningCharge
  LightningChargeFill
  LightningFill
  Line
  Link
  Link45deg
  Linkedin
  List
  ListCheck
  ListColumns
  ListColumnsReverse
  ListNested
  ListOl
  ListStars
  ListTask
  ListUl
  Lock
  LockFill
  Luggage
  LuggageFill
  Lungs
  LungsFill
  Magic
  Magnet
  MagnetFill
  Mailbox
  MailboxFlag
  Mailbox2
  Mailbox2Flag
  Map
  MapFill
  Markdown
  MarkdownFill
  MarkerTip
  Mask
  Mastodon
  Medium
  Megaphone
  MegaphoneFill
  Memory
  MenuApp
  MenuAppFill
  MenuButton
  MenuButtonFill
  MenuButtonWide
  MenuButtonWideFill
  MenuDown
  MenuUp
  Messenger
  Meta
  Mic
  MicFill
  MicMute
  MicMuteFill
  Microsoft
  MicrosoftTeams
  Minecart
  MinecartLoaded
  Modem
  ModemFill
  Moisture
  Moon
  MoonFill
  MoonStars
  MoonStarsFill
  Mortarboard
  MortarboardFill
  Motherboard
  MotherboardFill
  Mouse
  MouseFill
  Mouse2
  Mouse2Fill
  Mouse3
  Mouse3Fill
  MusicNote
  MusicNoteBeamed
  MusicNoteList
  MusicPlayer
  MusicPlayerFill
  Newspaper
  NintendoSwitch
  NodeMinus
  NodeMinusFill
  NodePlus
  NodePlusFill
  NoiseReduction
  Nut
  NutFill
  Nvidia
  Nvme
  NvmeFill
  Octagon
  OctagonFill
  OctagonHalf
  Opencollective
  OpticalAudio
  OpticalAudioFill
  Option
  Outlet
  PCircle
  PCircleFill
  PSquare
  PSquareFill
  PaintBucket
  Palette
  PaletteFill
  Palette2
  Paperclip
  Paragraph
  Pass
  PassFill
  Passport
  PassportFill
  PatchCheck
  PatchCheckFill
  PatchExclamation
  PatchExclamationFill
  PatchMinus
  PatchMinusFill
  PatchPlus
  PatchPlusFill
  PatchQuestion
  PatchQuestionFill
  Pause
  PauseBtn
  PauseBtnFill
  PauseCircle
  PauseCircleFill
  PauseFill
  Paypal
  Pc
  PcDisplay
  PcDisplayHorizontal
  PcHorizontal
  PciCard
  PciCardNetwork
  PciCardSound
  Peace
  PeaceFill
  Pen
  PenFill
  Pencil
  PencilFill
  PencilSquare
  Pentagon
  PentagonFill
  PentagonHalf
  People
  PeopleFill
  Percent
  Person
  PersonAdd
  PersonArmsUp
  PersonBadge
  PersonBadgeFill
  PersonBoundingBox
  PersonCheck
  PersonCheckFill
  PersonCircle
  PersonDash
  PersonDashFill
  PersonDown
  PersonExclamation
  PersonFill
  PersonFillAdd
  PersonFillCheck
  PersonFillDash
  PersonFillDown
  PersonFillExclamation
  PersonFillGear
  PersonFillLock
  PersonFillSlash
  PersonFillUp
  PersonFillX
  PersonGear
  PersonHeart
  PersonHearts
  PersonLinesFill
  PersonLock
  PersonPlus
  PersonPlusFill
  PersonRaisedHand
  PersonRolodex
  PersonSlash
  PersonSquare
  PersonStanding
  PersonStandingDress
  PersonUp
  PersonVcard
  PersonVcardFill
  PersonVideo
  PersonVideo2
  PersonVideo3
  PersonWalking
  PersonWheelchair
  PersonWorkspace
  PersonX
  PersonXFill
  Phone
  PhoneFill
  PhoneFlip
  PhoneLandscape
  PhoneLandscapeFill
  PhoneVibrate
  PhoneVibrateFill
  PieChart
  PieChartFill
  PiggyBank
  PiggyBankFill
  Pin
  PinAngle
  PinAngleFill
  PinFill
  PinMap
  PinMapFill
  Pinterest
  Pip
  PipFill
  Play
  PlayBtn
  PlayBtnFill
  PlayCircle
  PlayCircleFill
  PlayFill
  Playstation
  Plug
  PlugFill
  Plugin
  Plus
  PlusCircle
  PlusCircleDotted
  PlusCircleFill
  PlusLg
  PlusSlashMinus
  PlusSquare
  PlusSquareDotted
  PlusSquareFill
  Postage
  PostageFill
  PostageHeart
  PostageHeartFill
  Postcard
  PostcardFill
  PostcardHeart
  PostcardHeartFill
  Power
  Prescription
  Prescription2
  Printer
  PrinterFill
  Projector
  ProjectorFill
  Puzzle
  PuzzleFill
  QrCode
  QrCodeScan
  Question
  QuestionCircle
  QuestionCircleFill
  QuestionDiamond
  QuestionDiamondFill
  QuestionLg
  QuestionOctagon
  QuestionOctagonFill
  QuestionSquare
  QuestionSquareFill
  Quora
  Quote
  RCircle
  RCircleFill
  RSquare
  RSquareFill
  Radar
  Radioactive
  Rainbow
  Receipt
  ReceiptCutoff
  Reception0
  Reception1
  Reception2
  Reception3
  Reception4
  Record
  RecordBtn
  RecordBtnFill
  RecordCircle
  RecordCircleFill
  RecordFill
  Record2
  Record2Fill
  Recycle
  Reddit
  Regex
  Repeat
  Repeat1
  Reply
  ReplyAll
  ReplyAllFill
  ReplyFill
  Rewind
  RewindBtn
  RewindBtnFill
  RewindCircle
  RewindCircleFill
  RewindFill
  Robot
  Rocket
  RocketFill
  RocketTakeoff
  RocketTakeoffFill
  Router
  RouterFill
  Rss
  RssFill
  Rulers
  Safe
  SafeFill
  Safe2
  Safe2Fill
  Save
  SaveFill
  Save2
  Save2Fill
  Scissors
  Scooter
  Screwdriver
  SdCard
  SdCardFill
  Search
  SearchHeart
  SearchHeartFill
  SegmentedNav
  Send
  SendArrowDown
  SendArrowDownFill
  SendArrowUp
  SendArrowUpFill
  SendCheck
  SendCheckFill
  SendDash
  SendDashFill
  SendExclamation
  SendExclamationFill
  SendFill
  SendPlus
  SendPlusFill
  SendSlash
  SendSlashFill
  SendX
  SendXFill
  Server
  Shadows
  Share
  ShareFill
  Shield
  ShieldCheck
  ShieldExclamation
  ShieldFill
  ShieldFillCheck
  ShieldFillExclamation
  ShieldFillMinus
  ShieldFillPlus
  ShieldFillX
  ShieldLock
  ShieldLockFill
  ShieldMinus
  ShieldPlus
  ShieldShaded
  ShieldSlash
  ShieldSlashFill
  ShieldX
  Shift
  ShiftFill
  Shop
  ShopWindow
  Shuffle
  SignDeadEnd
  SignDeadEndFill
  SignDoNotEnter
  SignDoNotEnterFill
  SignIntersection
  SignIntersectionFill
  SignIntersectionSide
  SignIntersectionSideFill
  SignIntersectionT
  SignIntersectionTFill
  SignIntersectionY
  SignIntersectionYFill
  SignMergeLeft
  SignMergeLeftFill
  SignMergeRight
  SignMergeRightFill
  SignNoLeftTurn
  SignNoLeftTurnFill
  SignNoParking
  SignNoParkingFill
  SignNoRightTurn
  SignNoRightTurnFill
  SignRailroad
  SignRailroadFill
  SignStop
  SignStopFill
  SignStopLights
  SignStopLightsFill
  SignTurnLeft
  SignTurnLeftFill
  SignTurnRight
  SignTurnRightFill
  SignTurnSlightLeft
  SignTurnSlightLeftFill
  SignTurnSlightRight
  SignTurnSlightRightFill
  SignYield
  SignYieldFill
  Signal
  Signpost
  Signpost2
  Signpost2Fill
  SignpostFill
  SignpostSplit
  SignpostSplitFill
  Sim
  SimFill
  SimSlash
  SimSlashFill
  SinaWeibo
  SkipBackward
  SkipBackwardBtn
  SkipBackwardBtnFill
  SkipBackwardCircle
  SkipBackwardCircleFill
  SkipBackwardFill
  SkipEnd
  SkipEndBtn
  SkipEndBtnFill
  SkipEndCircle
  SkipEndCircleFill
  SkipEndFill
  SkipForward
  SkipForwardBtn
  SkipForwardBtnFill
  SkipForwardCircle
  SkipForwardCircleFill
  SkipForwardFill
  SkipStart
  SkipStartBtn
  SkipStartBtnFill
  SkipStartCircle
  SkipStartCircleFill
  SkipStartFill
  Skype
  Slack
  Slash
  SlashCircle
  SlashCircleFill
  SlashLg
  SlashSquare
  SlashSquareFill
  Sliders
  Sliders2
  Sliders2Vertical
  Smartwatch
  Snapchat
  Snow
  Snow2
  Snow3
  SortAlphaDown
  SortAlphaDownAlt
  SortAlphaUp
  SortAlphaUpAlt
  SortDown
  SortDownAlt
  SortNumericDown
  SortNumericDownAlt
  SortNumericUp
  SortNumericUpAlt
  SortUp
  SortUpAlt
  Soundwave
  Sourceforge
  Speaker
  SpeakerFill
  Speedometer
  Speedometer2
  Spellcheck
  Spotify
  Square
  SquareFill
  SquareHalf
  Stack
  StackOverflow
  Star
  StarFill
  StarHalf
  Stars
  Steam
  Stickies
  StickiesFill
  Sticky
  StickyFill
  Stop
  StopBtn
  StopBtnFill
  StopCircle
  StopCircleFill
  StopFill
  Stoplights
  StoplightsFill
  Stopwatch
  StopwatchFill
  Strava
  Stripe
  Subscript
  Substack
  Subtract
  SuitClub
  SuitClubFill
  SuitDiamond
  SuitDiamondFill
  SuitHeart
  SuitHeartFill
  SuitSpade
  SuitSpadeFill
  Suitcase
  SuitcaseFill
  SuitcaseLg
  SuitcaseLgFill
  Suitcase2
  Suitcase2Fill
  Sun
  SunFill
  Sunglasses
  Sunrise
  SunriseFill
  Sunset
  SunsetFill
  Superscript
  SymmetryHorizontal
  SymmetryVertical
  Table
  Tablet
  TabletFill
  TabletLandscape
  TabletLandscapeFill
  Tag
  TagFill
  Tags
  TagsFill
  TaxiFront
  TaxiFrontFill
  Telegram
  Telephone
  TelephoneFill
  TelephoneForward
  TelephoneForwardFill
  TelephoneInbound
  TelephoneInboundFill
  TelephoneMinus
  TelephoneMinusFill
  TelephoneOutbound
  TelephoneOutboundFill
  TelephonePlus
  TelephonePlusFill
  TelephoneX
  TelephoneXFill
  TencentQq
  Terminal
  TerminalDash
  TerminalFill
  TerminalPlus
  TerminalSplit
  TerminalX
  TextCenter
  TextIndentLeft
  TextIndentRight
  TextLeft
  TextParagraph
  TextRight
  TextWrap
  Textarea
  TextareaResize
  TextareaT
  Thermometer
  ThermometerHalf
  ThermometerHigh
  ThermometerLow
  ThermometerSnow
  ThermometerSun
  Threads
  ThreadsFill
  ThreeDots
  ThreeDotsVertical
  Thunderbolt
  ThunderboltFill
  Ticket
  TicketDetailed
  TicketDetailedFill
  TicketFill
  TicketPerforated
  TicketPerforatedFill
  Tiktok
  ToggleOff
  ToggleOn
  Toggle2Off
  Toggle2On
  Toggles
  Toggles2
  Tools
  Tornado
  TrainFreightFront
  TrainFreightFrontFill
  TrainFront
  TrainFrontFill
  TrainLightrailFront
  TrainLightrailFrontFill
  Translate
  Transparency
  Trash
  TrashFill
  Trash2
  Trash2Fill
  Trash3
  Trash3Fill
  Tree
  TreeFill
  Trello
  Triangle
  TriangleFill
  TriangleHalf
  Trophy
  TrophyFill
  TropicalStorm
  Truck
  TruckFlatbed
  TruckFront
  TruckFrontFill
  Tsunami
  Tv
  TvFill
  Twitch
  Twitter
  TwitterX
  Type
  TypeBold
  TypeH1
  TypeH2
  TypeH3
  TypeH4
  TypeH5
  TypeH6
  TypeItalic
  TypeStrikethrough
  TypeUnderline
  Ubuntu
  UiChecks
  UiChecksGrid
  UiRadios
  UiRadiosGrid
  Umbrella
  UmbrellaFill
  Unindent
  Union
  Unity
  UniversalAccess
  UniversalAccessCircle
  Unlock
  UnlockFill
  Upc
  UpcScan
  Upload
  Usb
  UsbC
  UsbCFill
  UsbDrive
  UsbDriveFill
  UsbFill
  UsbMicro
  UsbMicroFill
  UsbMini
  UsbMiniFill
  UsbPlug
  UsbPlugFill
  UsbSymbol
  Valentine
  Valentine2
  VectorPen
  ViewList
  ViewStacked
  Vignette
  Vimeo
  Vinyl
  VinylFill
  Virus
  Virus2
  Voicemail
  VolumeDown
  VolumeDownFill
  VolumeMute
  VolumeMuteFill
  VolumeOff
  VolumeOffFill
  VolumeUp
  VolumeUpFill
  Vr
  Wallet
  WalletFill
  Wallet2
  Watch
  Water
  Webcam
  WebcamFill
  Wechat
  Whatsapp
  Wifi
  Wifi1
  Wifi2
  WifiOff
  Wikipedia
  Wind
  Window
  WindowDash
  WindowDesktop
  WindowDock
  WindowFullscreen
  WindowPlus
  WindowSidebar
  WindowSplit
  WindowStack
  WindowX
  Windows
  Wordpress
  Wrench
  WrenchAdjustable
  WrenchAdjustableCircle
  WrenchAdjustableCircleFill
  X
  XCircle
  XCircleFill
  XDiamond
  XDiamondFill
  XLg
  XOctagon
  XOctagonFill
  XSquare
  XSquareFill
  Xbox
  Yelp
  YinYang
  Youtube
  ZoomIn
  ZoomOut
}

fn stringify_item_type(item_type: IconType) -> String {
  case item_type {
    Num0Circle -> "0-circle"
    Num0CircleFill -> "0-circle-fill"
    Num0Square -> "0-square"
    Num0SquareFill -> "0-square-fill"
    Num1Circle -> "1-circle"
    Num1CircleFill -> "1-circle-fill"
    Num1Square -> "1-square"
    Num1SquareFill -> "1-square-fill"
    Num123 -> "123"
    Num2Circle -> "2-circle"
    Num2CircleFill -> "2-circle-fill"
    Num2Square -> "2-square"
    Num2SquareFill -> "2-square-fill"
    Num3Circle -> "3-circle"
    Num3CircleFill -> "3-circle-fill"
    Num3Square -> "3-square"
    Num3SquareFill -> "3-square-fill"
    Num4Circle -> "4-circle"
    Num4CircleFill -> "4-circle-fill"
    Num4Square -> "4-square"
    Num4SquareFill -> "4-square-fill"
    Num5Circle -> "5-circle"
    Num5CircleFill -> "5-circle-fill"
    Num5Square -> "5-square"
    Num5SquareFill -> "5-square-fill"
    Num6Circle -> "6-circle"
    Num6CircleFill -> "6-circle-fill"
    Num6Square -> "6-square"
    Num6SquareFill -> "6-square-fill"
    Num7Circle -> "7-circle"
    Num7CircleFill -> "7-circle-fill"
    Num7Square -> "7-square"
    Num7SquareFill -> "7-square-fill"
    Num8Circle -> "8-circle"
    Num8CircleFill -> "8-circle-fill"
    Num8Square -> "8-square"
    Num8SquareFill -> "8-square-fill"
    Num9Circle -> "9-circle"
    Num9CircleFill -> "9-circle-fill"
    Num9Square -> "9-square"
    Num9SquareFill -> "9-square-fill"
    Activity -> "activity"
    Airplane -> "airplane"
    AirplaneEngines -> "airplane-engines"
    AirplaneEnginesFill -> "airplane-engines-fill"
    AirplaneFill -> "airplane-fill"
    Alarm -> "alarm"
    AlarmFill -> "alarm-fill"
    Alexa -> "alexa"
    AlignBottom -> "align-bottom"
    AlignCenter -> "align-center"
    AlignEnd -> "align-end"
    AlignMiddle -> "align-middle"
    AlignStart -> "align-start"
    AlignTop -> "align-top"
    Alipay -> "alipay"
    Alphabet -> "alphabet"
    AlphabetUppercase -> "alphabet-uppercase"
    Alt -> "alt"
    Amazon -> "amazon"
    Amd -> "amd"
    Android -> "android"
    Android2 -> "android2"
    App -> "app"
    AppIndicator -> "app-indicator"
    Apple -> "apple"
    Archive -> "archive"
    ArchiveFill -> "archive-fill"
    Arrow90degDown -> "arrow-90deg-down"
    Arrow90degLeft -> "arrow-90deg-left"
    Arrow90degRight -> "arrow-90deg-right"
    Arrow90degUp -> "arrow-90deg-up"
    ArrowBarDown -> "arrow-bar-down"
    ArrowBarLeft -> "arrow-bar-left"
    ArrowBarRight -> "arrow-bar-right"
    ArrowBarUp -> "arrow-bar-up"
    ArrowClockwise -> "arrow-clockwise"
    ArrowCounterclockwise -> "arrow-counterclockwise"
    ArrowDown -> "arrow-down"
    ArrowDownCircle -> "arrow-down-circle"
    ArrowDownCircleFill -> "arrow-down-circle-fill"
    ArrowDownLeft -> "arrow-down-left"
    ArrowDownLeftCircle -> "arrow-down-left-circle"
    ArrowDownLeftCircleFill -> "arrow-down-left-circle-fill"
    ArrowDownLeftSquare -> "arrow-down-left-square"
    ArrowDownLeftSquareFill -> "arrow-down-left-square-fill"
    ArrowDownRight -> "arrow-down-right"
    ArrowDownRightCircle -> "arrow-down-right-circle"
    ArrowDownRightCircleFill -> "arrow-down-right-circle-fill"
    ArrowDownRightSquare -> "arrow-down-right-square"
    ArrowDownRightSquareFill -> "arrow-down-right-square-fill"
    ArrowDownShort -> "arrow-down-short"
    ArrowDownSquare -> "arrow-down-square"
    ArrowDownSquareFill -> "arrow-down-square-fill"
    ArrowDownUp -> "arrow-down-up"
    ArrowLeft -> "arrow-left"
    ArrowLeftCircle -> "arrow-left-circle"
    ArrowLeftCircleFill -> "arrow-left-circle-fill"
    ArrowLeftRight -> "arrow-left-right"
    ArrowLeftShort -> "arrow-left-short"
    ArrowLeftSquare -> "arrow-left-square"
    ArrowLeftSquareFill -> "arrow-left-square-fill"
    ArrowRepeat -> "arrow-repeat"
    ArrowReturnLeft -> "arrow-return-left"
    ArrowReturnRight -> "arrow-return-right"
    ArrowRight -> "arrow-right"
    ArrowRightCircle -> "arrow-right-circle"
    ArrowRightCircleFill -> "arrow-right-circle-fill"
    ArrowRightShort -> "arrow-right-short"
    ArrowRightSquare -> "arrow-right-square"
    ArrowRightSquareFill -> "arrow-right-square-fill"
    ArrowThroughHeart -> "arrow-through-heart"
    ArrowThroughHeartFill -> "arrow-through-heart-fill"
    ArrowUp -> "arrow-up"
    ArrowUpCircle -> "arrow-up-circle"
    ArrowUpCircleFill -> "arrow-up-circle-fill"
    ArrowUpLeft -> "arrow-up-left"
    ArrowUpLeftCircle -> "arrow-up-left-circle"
    ArrowUpLeftCircleFill -> "arrow-up-left-circle-fill"
    ArrowUpLeftSquare -> "arrow-up-left-square"
    ArrowUpLeftSquareFill -> "arrow-up-left-square-fill"
    ArrowUpRight -> "arrow-up-right"
    ArrowUpRightCircle -> "arrow-up-right-circle"
    ArrowUpRightCircleFill -> "arrow-up-right-circle-fill"
    ArrowUpRightSquare -> "arrow-up-right-square"
    ArrowUpRightSquareFill -> "arrow-up-right-square-fill"
    ArrowUpShort -> "arrow-up-short"
    ArrowUpSquare -> "arrow-up-square"
    ArrowUpSquareFill -> "arrow-up-square-fill"
    Arrows -> "arrows"
    ArrowsAngleContract -> "arrows-angle-contract"
    ArrowsAngleExpand -> "arrows-angle-expand"
    ArrowsCollapse -> "arrows-collapse"
    ArrowsCollapseVertical -> "arrows-collapse-vertical"
    ArrowsExpand -> "arrows-expand"
    ArrowsExpandVertical -> "arrows-expand-vertical"
    ArrowsFullscreen -> "arrows-fullscreen"
    ArrowsMove -> "arrows-move"
    ArrowsVertical -> "arrows-vertical"
    AspectRatio -> "aspect-ratio"
    AspectRatioFill -> "aspect-ratio-fill"
    Asterisk -> "asterisk"
    At -> "at"
    Award -> "award"
    AwardFill -> "award-fill"
    Back -> "back"
    Backpack -> "backpack"
    BackpackFill -> "backpack-fill"
    Backpack2 -> "backpack2"
    Backpack2Fill -> "backpack2-fill"
    Backpack3 -> "backpack3"
    Backpack3Fill -> "backpack3-fill"
    Backpack4 -> "backpack4"
    Backpack4Fill -> "backpack4-fill"
    Backspace -> "backspace"
    BackspaceFill -> "backspace-fill"
    BackspaceReverse -> "backspace-reverse"
    BackspaceReverseFill -> "backspace-reverse-fill"
    Badge3d -> "badge-3d"
    Badge3dFill -> "badge-3d-fill"
    Badge4k -> "badge-4k"
    Badge4kFill -> "badge-4k-fill"
    Badge8k -> "badge-8k"
    Badge8kFill -> "badge-8k-fill"
    BadgeAd -> "badge-ad"
    BadgeAdFill -> "badge-ad-fill"
    BadgeAr -> "badge-ar"
    BadgeArFill -> "badge-ar-fill"
    BadgeCc -> "badge-cc"
    BadgeCcFill -> "badge-cc-fill"
    BadgeHd -> "badge-hd"
    BadgeHdFill -> "badge-hd-fill"
    BadgeSd -> "badge-sd"
    BadgeSdFill -> "badge-sd-fill"
    BadgeTm -> "badge-tm"
    BadgeTmFill -> "badge-tm-fill"
    BadgeVo -> "badge-vo"
    BadgeVoFill -> "badge-vo-fill"
    BadgeVr -> "badge-vr"
    BadgeVrFill -> "badge-vr-fill"
    BadgeWc -> "badge-wc"
    BadgeWcFill -> "badge-wc-fill"
    Bag -> "bag"
    BagCheck -> "bag-check"
    BagCheckFill -> "bag-check-fill"
    BagDash -> "bag-dash"
    BagDashFill -> "bag-dash-fill"
    BagFill -> "bag-fill"
    BagHeart -> "bag-heart"
    BagHeartFill -> "bag-heart-fill"
    BagPlus -> "bag-plus"
    BagPlusFill -> "bag-plus-fill"
    BagX -> "bag-x"
    BagXFill -> "bag-x-fill"
    Balloon -> "balloon"
    BalloonFill -> "balloon-fill"
    BalloonHeart -> "balloon-heart"
    BalloonHeartFill -> "balloon-heart-fill"
    Ban -> "ban"
    BanFill -> "ban-fill"
    Bandaid -> "bandaid"
    BandaidFill -> "bandaid-fill"
    Bank -> "bank"
    Bank2 -> "bank2"
    BarChart -> "bar-chart"
    BarChartFill -> "bar-chart-fill"
    BarChartLine -> "bar-chart-line"
    BarChartLineFill -> "bar-chart-line-fill"
    BarChartSteps -> "bar-chart-steps"
    Basket -> "basket"
    BasketFill -> "basket-fill"
    Basket2 -> "basket2"
    Basket2Fill -> "basket2-fill"
    Basket3 -> "basket3"
    Basket3Fill -> "basket3-fill"
    Battery -> "battery"
    BatteryCharging -> "battery-charging"
    BatteryFull -> "battery-full"
    BatteryHalf -> "battery-half"
    Behance -> "behance"
    Bell -> "bell"
    BellFill -> "bell-fill"
    BellSlash -> "bell-slash"
    BellSlashFill -> "bell-slash-fill"
    Bezier -> "bezier"
    Bezier2 -> "bezier2"
    Bicycle -> "bicycle"
    Bing -> "bing"
    Binoculars -> "binoculars"
    BinocularsFill -> "binoculars-fill"
    BlockquoteLeft -> "blockquote-left"
    BlockquoteRight -> "blockquote-right"
    Bluetooth -> "bluetooth"
    BodyText -> "body-text"
    Book -> "book"
    BookFill -> "book-fill"
    BookHalf -> "book-half"
    Bookmark -> "bookmark"
    BookmarkCheck -> "bookmark-check"
    BookmarkCheckFill -> "bookmark-check-fill"
    BookmarkDash -> "bookmark-dash"
    BookmarkDashFill -> "bookmark-dash-fill"
    BookmarkFill -> "bookmark-fill"
    BookmarkHeart -> "bookmark-heart"
    BookmarkHeartFill -> "bookmark-heart-fill"
    BookmarkPlus -> "bookmark-plus"
    BookmarkPlusFill -> "bookmark-plus-fill"
    BookmarkStar -> "bookmark-star"
    BookmarkStarFill -> "bookmark-star-fill"
    BookmarkX -> "bookmark-x"
    BookmarkXFill -> "bookmark-x-fill"
    Bookmarks -> "bookmarks"
    BookmarksFill -> "bookmarks-fill"
    Bookshelf -> "bookshelf"
    Boombox -> "boombox"
    BoomboxFill -> "boombox-fill"
    Bootstrap -> "bootstrap"
    BootstrapFill -> "bootstrap-fill"
    BootstrapReboot -> "bootstrap-reboot"
    Border -> "border"
    BorderAll -> "border-all"
    BorderBottom -> "border-bottom"
    BorderCenter -> "border-center"
    BorderInner -> "border-inner"
    BorderLeft -> "border-left"
    BorderMiddle -> "border-middle"
    BorderOuter -> "border-outer"
    BorderRight -> "border-right"
    BorderStyle -> "border-style"
    BorderTop -> "border-top"
    BorderWidth -> "border-width"
    BoundingBox -> "bounding-box"
    BoundingBoxCircles -> "bounding-box-circles"
    Box -> "box"
    BoxArrowDown -> "box-arrow-down"
    BoxArrowDownLeft -> "box-arrow-down-left"
    BoxArrowDownRight -> "box-arrow-down-right"
    BoxArrowInDown -> "box-arrow-in-down"
    BoxArrowInDownLeft -> "box-arrow-in-down-left"
    BoxArrowInDownRight -> "box-arrow-in-down-right"
    BoxArrowInLeft -> "box-arrow-in-left"
    BoxArrowInRight -> "box-arrow-in-right"
    BoxArrowInUp -> "box-arrow-in-up"
    BoxArrowInUpLeft -> "box-arrow-in-up-left"
    BoxArrowInUpRight -> "box-arrow-in-up-right"
    BoxArrowLeft -> "box-arrow-left"
    BoxArrowRight -> "box-arrow-right"
    BoxArrowUp -> "box-arrow-up"
    BoxArrowUpLeft -> "box-arrow-up-left"
    BoxArrowUpRight -> "box-arrow-up-right"
    BoxFill -> "box-fill"
    BoxSeam -> "box-seam"
    BoxSeamFill -> "box-seam-fill"
    Box2 -> "box2"
    Box2Fill -> "box2-fill"
    Box2Heart -> "box2-heart"
    Box2HeartFill -> "box2-heart-fill"
    Boxes -> "boxes"
    Braces -> "braces"
    BracesAsterisk -> "braces-asterisk"
    Bricks -> "bricks"
    Briefcase -> "briefcase"
    BriefcaseFill -> "briefcase-fill"
    BrightnessAltHigh -> "brightness-alt-high"
    BrightnessAltHighFill -> "brightness-alt-high-fill"
    BrightnessAltLow -> "brightness-alt-low"
    BrightnessAltLowFill -> "brightness-alt-low-fill"
    BrightnessHigh -> "brightness-high"
    BrightnessHighFill -> "brightness-high-fill"
    BrightnessLow -> "brightness-low"
    BrightnessLowFill -> "brightness-low-fill"
    Brilliance -> "brilliance"
    Broadcast -> "broadcast"
    BroadcastPin -> "broadcast-pin"
    BrowserChrome -> "browser-chrome"
    BrowserEdge -> "browser-edge"
    BrowserFirefox -> "browser-firefox"
    BrowserSafari -> "browser-safari"
    Brush -> "brush"
    BrushFill -> "brush-fill"
    Bucket -> "bucket"
    BucketFill -> "bucket-fill"
    Bug -> "bug"
    BugFill -> "bug-fill"
    Building -> "building"
    BuildingAdd -> "building-add"
    BuildingCheck -> "building-check"
    BuildingDash -> "building-dash"
    BuildingDown -> "building-down"
    BuildingExclamation -> "building-exclamation"
    BuildingFill -> "building-fill"
    BuildingFillAdd -> "building-fill-add"
    BuildingFillCheck -> "building-fill-check"
    BuildingFillDash -> "building-fill-dash"
    BuildingFillDown -> "building-fill-down"
    BuildingFillExclamation -> "building-fill-exclamation"
    BuildingFillGear -> "building-fill-gear"
    BuildingFillLock -> "building-fill-lock"
    BuildingFillSlash -> "building-fill-slash"
    BuildingFillUp -> "building-fill-up"
    BuildingFillX -> "building-fill-x"
    BuildingGear -> "building-gear"
    BuildingLock -> "building-lock"
    BuildingSlash -> "building-slash"
    BuildingUp -> "building-up"
    BuildingX -> "building-x"
    Buildings -> "buildings"
    BuildingsFill -> "buildings-fill"
    Bullseye -> "bullseye"
    BusFront -> "bus-front"
    BusFrontFill -> "bus-front-fill"
    CCircle -> "c-circle"
    CCircleFill -> "c-circle-fill"
    CSquare -> "c-square"
    CSquareFill -> "c-square-fill"
    Cake -> "cake"
    CakeFill -> "cake-fill"
    Cake2 -> "cake2"
    Cake2Fill -> "cake2-fill"
    Calculator -> "calculator"
    CalculatorFill -> "calculator-fill"
    Calendar -> "calendar"
    CalendarCheck -> "calendar-check"
    CalendarCheckFill -> "calendar-check-fill"
    CalendarDate -> "calendar-date"
    CalendarDateFill -> "calendar-date-fill"
    CalendarDay -> "calendar-day"
    CalendarDayFill -> "calendar-day-fill"
    CalendarEvent -> "calendar-event"
    CalendarEventFill -> "calendar-event-fill"
    CalendarFill -> "calendar-fill"
    CalendarHeart -> "calendar-heart"
    CalendarHeartFill -> "calendar-heart-fill"
    CalendarMinus -> "calendar-minus"
    CalendarMinusFill -> "calendar-minus-fill"
    CalendarMonth -> "calendar-month"
    CalendarMonthFill -> "calendar-month-fill"
    CalendarPlus -> "calendar-plus"
    CalendarPlusFill -> "calendar-plus-fill"
    CalendarRange -> "calendar-range"
    CalendarRangeFill -> "calendar-range-fill"
    CalendarWeek -> "calendar-week"
    CalendarWeekFill -> "calendar-week-fill"
    CalendarX -> "calendar-x"
    CalendarXFill -> "calendar-x-fill"
    Calendar2 -> "calendar2"
    Calendar2Check -> "calendar2-check"
    Calendar2CheckFill -> "calendar2-check-fill"
    Calendar2Date -> "calendar2-date"
    Calendar2DateFill -> "calendar2-date-fill"
    Calendar2Day -> "calendar2-day"
    Calendar2DayFill -> "calendar2-day-fill"
    Calendar2Event -> "calendar2-event"
    Calendar2EventFill -> "calendar2-event-fill"
    Calendar2Fill -> "calendar2-fill"
    Calendar2Heart -> "calendar2-heart"
    Calendar2HeartFill -> "calendar2-heart-fill"
    Calendar2Minus -> "calendar2-minus"
    Calendar2MinusFill -> "calendar2-minus-fill"
    Calendar2Month -> "calendar2-month"
    Calendar2MonthFill -> "calendar2-month-fill"
    Calendar2Plus -> "calendar2-plus"
    Calendar2PlusFill -> "calendar2-plus-fill"
    Calendar2Range -> "calendar2-range"
    Calendar2RangeFill -> "calendar2-range-fill"
    Calendar2Week -> "calendar2-week"
    Calendar2WeekFill -> "calendar2-week-fill"
    Calendar2X -> "calendar2-x"
    Calendar2XFill -> "calendar2-x-fill"
    Calendar3 -> "calendar3"
    Calendar3Event -> "calendar3-event"
    Calendar3EventFill -> "calendar3-event-fill"
    Calendar3Fill -> "calendar3-fill"
    Calendar3Range -> "calendar3-range"
    Calendar3RangeFill -> "calendar3-range-fill"
    Calendar3Week -> "calendar3-week"
    Calendar3WeekFill -> "calendar3-week-fill"
    Calendar4 -> "calendar4"
    Calendar4Event -> "calendar4-event"
    Calendar4Range -> "calendar4-range"
    Calendar4Week -> "calendar4-week"
    Camera -> "camera"
    CameraFill -> "camera-fill"
    CameraReels -> "camera-reels"
    CameraReelsFill -> "camera-reels-fill"
    CameraVideo -> "camera-video"
    CameraVideoFill -> "camera-video-fill"
    CameraVideoOff -> "camera-video-off"
    CameraVideoOffFill -> "camera-video-off-fill"
    Camera2 -> "camera2"
    Capslock -> "capslock"
    CapslockFill -> "capslock-fill"
    Capsule -> "capsule"
    CapsulePill -> "capsule-pill"
    CarFront -> "car-front"
    CarFrontFill -> "car-front-fill"
    CardChecklist -> "card-checklist"
    CardHeading -> "card-heading"
    CardImage -> "card-image"
    CardList -> "card-list"
    CardText -> "card-text"
    CaretDown -> "caret-down"
    CaretDownFill -> "caret-down-fill"
    CaretDownSquare -> "caret-down-square"
    CaretDownSquareFill -> "caret-down-square-fill"
    CaretLeft -> "caret-left"
    CaretLeftFill -> "caret-left-fill"
    CaretLeftSquare -> "caret-left-square"
    CaretLeftSquareFill -> "caret-left-square-fill"
    CaretRight -> "caret-right"
    CaretRightFill -> "caret-right-fill"
    CaretRightSquare -> "caret-right-square"
    CaretRightSquareFill -> "caret-right-square-fill"
    CaretUp -> "caret-up"
    CaretUpFill -> "caret-up-fill"
    CaretUpSquare -> "caret-up-square"
    CaretUpSquareFill -> "caret-up-square-fill"
    Cart -> "cart"
    CartCheck -> "cart-check"
    CartCheckFill -> "cart-check-fill"
    CartDash -> "cart-dash"
    CartDashFill -> "cart-dash-fill"
    CartFill -> "cart-fill"
    CartPlus -> "cart-plus"
    CartPlusFill -> "cart-plus-fill"
    CartX -> "cart-x"
    CartXFill -> "cart-x-fill"
    Cart2 -> "cart2"
    Cart3 -> "cart3"
    Cart4 -> "cart4"
    Cash -> "cash"
    CashCoin -> "cash-coin"
    CashStack -> "cash-stack"
    Cassette -> "cassette"
    CassetteFill -> "cassette-fill"
    Cast -> "cast"
    CcCircle -> "cc-circle"
    CcCircleFill -> "cc-circle-fill"
    CcSquare -> "cc-square"
    CcSquareFill -> "cc-square-fill"
    Chat -> "chat"
    ChatDots -> "chat-dots"
    ChatDotsFill -> "chat-dots-fill"
    ChatFill -> "chat-fill"
    ChatHeart -> "chat-heart"
    ChatHeartFill -> "chat-heart-fill"
    ChatLeft -> "chat-left"
    ChatLeftDots -> "chat-left-dots"
    ChatLeftDotsFill -> "chat-left-dots-fill"
    ChatLeftFill -> "chat-left-fill"
    ChatLeftHeart -> "chat-left-heart"
    ChatLeftHeartFill -> "chat-left-heart-fill"
    ChatLeftQuote -> "chat-left-quote"
    ChatLeftQuoteFill -> "chat-left-quote-fill"
    ChatLeftText -> "chat-left-text"
    ChatLeftTextFill -> "chat-left-text-fill"
    ChatQuote -> "chat-quote"
    ChatQuoteFill -> "chat-quote-fill"
    ChatRight -> "chat-right"
    ChatRightDots -> "chat-right-dots"
    ChatRightDotsFill -> "chat-right-dots-fill"
    ChatRightFill -> "chat-right-fill"
    ChatRightHeart -> "chat-right-heart"
    ChatRightHeartFill -> "chat-right-heart-fill"
    ChatRightQuote -> "chat-right-quote"
    ChatRightQuoteFill -> "chat-right-quote-fill"
    ChatRightText -> "chat-right-text"
    ChatRightTextFill -> "chat-right-text-fill"
    ChatSquare -> "chat-square"
    ChatSquareDots -> "chat-square-dots"
    ChatSquareDotsFill -> "chat-square-dots-fill"
    ChatSquareFill -> "chat-square-fill"
    ChatSquareHeart -> "chat-square-heart"
    ChatSquareHeartFill -> "chat-square-heart-fill"
    ChatSquareQuote -> "chat-square-quote"
    ChatSquareQuoteFill -> "chat-square-quote-fill"
    ChatSquareText -> "chat-square-text"
    ChatSquareTextFill -> "chat-square-text-fill"
    ChatText -> "chat-text"
    ChatTextFill -> "chat-text-fill"
    Check -> "check"
    CheckAll -> "check-all"
    CheckCircle -> "check-circle"
    CheckCircleFill -> "check-circle-fill"
    CheckLg -> "check-lg"
    CheckSquare -> "check-square"
    CheckSquareFill -> "check-square-fill"
    Check2 -> "check2"
    Check2All -> "check2-all"
    Check2Circle -> "check2-circle"
    Check2Square -> "check2-square"
    ChevronBarContract -> "chevron-bar-contract"
    ChevronBarDown -> "chevron-bar-down"
    ChevronBarExpand -> "chevron-bar-expand"
    ChevronBarLeft -> "chevron-bar-left"
    ChevronBarRight -> "chevron-bar-right"
    ChevronBarUp -> "chevron-bar-up"
    ChevronCompactDown -> "chevron-compact-down"
    ChevronCompactLeft -> "chevron-compact-left"
    ChevronCompactRight -> "chevron-compact-right"
    ChevronCompactUp -> "chevron-compact-up"
    ChevronContract -> "chevron-contract"
    ChevronDoubleDown -> "chevron-double-down"
    ChevronDoubleLeft -> "chevron-double-left"
    ChevronDoubleRight -> "chevron-double-right"
    ChevronDoubleUp -> "chevron-double-up"
    ChevronDown -> "chevron-down"
    ChevronExpand -> "chevron-expand"
    ChevronLeft -> "chevron-left"
    ChevronRight -> "chevron-right"
    ChevronUp -> "chevron-up"
    Circle -> "circle"
    CircleFill -> "circle-fill"
    CircleHalf -> "circle-half"
    CircleSquare -> "circle-square"
    Clipboard -> "clipboard"
    ClipboardCheck -> "clipboard-check"
    ClipboardCheckFill -> "clipboard-check-fill"
    ClipboardData -> "clipboard-data"
    ClipboardDataFill -> "clipboard-data-fill"
    ClipboardFill -> "clipboard-fill"
    ClipboardHeart -> "clipboard-heart"
    ClipboardHeartFill -> "clipboard-heart-fill"
    ClipboardMinus -> "clipboard-minus"
    ClipboardMinusFill -> "clipboard-minus-fill"
    ClipboardPlus -> "clipboard-plus"
    ClipboardPlusFill -> "clipboard-plus-fill"
    ClipboardPulse -> "clipboard-pulse"
    ClipboardX -> "clipboard-x"
    ClipboardXFill -> "clipboard-x-fill"
    Clipboard2 -> "clipboard2"
    Clipboard2Check -> "clipboard2-check"
    Clipboard2CheckFill -> "clipboard2-check-fill"
    Clipboard2Data -> "clipboard2-data"
    Clipboard2DataFill -> "clipboard2-data-fill"
    Clipboard2Fill -> "clipboard2-fill"
    Clipboard2Heart -> "clipboard2-heart"
    Clipboard2HeartFill -> "clipboard2-heart-fill"
    Clipboard2Minus -> "clipboard2-minus"
    Clipboard2MinusFill -> "clipboard2-minus-fill"
    Clipboard2Plus -> "clipboard2-plus"
    Clipboard2PlusFill -> "clipboard2-plus-fill"
    Clipboard2Pulse -> "clipboard2-pulse"
    Clipboard2PulseFill -> "clipboard2-pulse-fill"
    Clipboard2X -> "clipboard2-x"
    Clipboard2XFill -> "clipboard2-x-fill"
    Clock -> "clock"
    ClockFill -> "clock-fill"
    ClockHistory -> "clock-history"
    Cloud -> "cloud"
    CloudArrowDown -> "cloud-arrow-down"
    CloudArrowDownFill -> "cloud-arrow-down-fill"
    CloudArrowUp -> "cloud-arrow-up"
    CloudArrowUpFill -> "cloud-arrow-up-fill"
    CloudCheck -> "cloud-check"
    CloudCheckFill -> "cloud-check-fill"
    CloudDownload -> "cloud-download"
    CloudDownloadFill -> "cloud-download-fill"
    CloudDrizzle -> "cloud-drizzle"
    CloudDrizzleFill -> "cloud-drizzle-fill"
    CloudFill -> "cloud-fill"
    CloudFog -> "cloud-fog"
    CloudFogFill -> "cloud-fog-fill"
    CloudFog2 -> "cloud-fog2"
    CloudFog2Fill -> "cloud-fog2-fill"
    CloudHail -> "cloud-hail"
    CloudHailFill -> "cloud-hail-fill"
    CloudHaze -> "cloud-haze"
    CloudHazeFill -> "cloud-haze-fill"
    CloudHaze2 -> "cloud-haze2"
    CloudHaze2Fill -> "cloud-haze2-fill"
    CloudLightning -> "cloud-lightning"
    CloudLightningFill -> "cloud-lightning-fill"
    CloudLightningRain -> "cloud-lightning-rain"
    CloudLightningRainFill -> "cloud-lightning-rain-fill"
    CloudMinus -> "cloud-minus"
    CloudMinusFill -> "cloud-minus-fill"
    CloudMoon -> "cloud-moon"
    CloudMoonFill -> "cloud-moon-fill"
    CloudPlus -> "cloud-plus"
    CloudPlusFill -> "cloud-plus-fill"
    CloudRain -> "cloud-rain"
    CloudRainFill -> "cloud-rain-fill"
    CloudRainHeavy -> "cloud-rain-heavy"
    CloudRainHeavyFill -> "cloud-rain-heavy-fill"
    CloudSlash -> "cloud-slash"
    CloudSlashFill -> "cloud-slash-fill"
    CloudSleet -> "cloud-sleet"
    CloudSleetFill -> "cloud-sleet-fill"
    CloudSnow -> "cloud-snow"
    CloudSnowFill -> "cloud-snow-fill"
    CloudSun -> "cloud-sun"
    CloudSunFill -> "cloud-sun-fill"
    CloudUpload -> "cloud-upload"
    CloudUploadFill -> "cloud-upload-fill"
    Clouds -> "clouds"
    CloudsFill -> "clouds-fill"
    Cloudy -> "cloudy"
    CloudyFill -> "cloudy-fill"
    Code -> "code"
    CodeSlash -> "code-slash"
    CodeSquare -> "code-square"
    Coin -> "coin"
    Collection -> "collection"
    CollectionFill -> "collection-fill"
    CollectionPlay -> "collection-play"
    CollectionPlayFill -> "collection-play-fill"
    Columns -> "columns"
    ColumnsGap -> "columns-gap"
    Command -> "command"
    Compass -> "compass"
    CompassFill -> "compass-fill"
    Cone -> "cone"
    ConeStriped -> "cone-striped"
    Controller -> "controller"
    Cookie -> "cookie"
    Copy -> "copy"
    Cpu -> "cpu"
    CpuFill -> "cpu-fill"
    CreditCard -> "credit-card"
    CreditCard2Back -> "credit-card-2-back"
    CreditCard2BackFill -> "credit-card-2-back-fill"
    CreditCard2Front -> "credit-card-2-front"
    CreditCard2FrontFill -> "credit-card-2-front-fill"
    CreditCardFill -> "credit-card-fill"
    Crop -> "crop"
    Crosshair -> "crosshair"
    Crosshair2 -> "crosshair2"
    Cup -> "cup"
    CupFill -> "cup-fill"
    CupHot -> "cup-hot"
    CupHotFill -> "cup-hot-fill"
    CupStraw -> "cup-straw"
    CurrencyBitcoin -> "currency-bitcoin"
    CurrencyDollar -> "currency-dollar"
    CurrencyEuro -> "currency-euro"
    CurrencyExchange -> "currency-exchange"
    CurrencyPound -> "currency-pound"
    CurrencyRupee -> "currency-rupee"
    CurrencyYen -> "currency-yen"
    Cursor -> "cursor"
    CursorFill -> "cursor-fill"
    CursorText -> "cursor-text"
    Dash -> "dash"
    DashCircle -> "dash-circle"
    DashCircleDotted -> "dash-circle-dotted"
    DashCircleFill -> "dash-circle-fill"
    DashLg -> "dash-lg"
    DashSquare -> "dash-square"
    DashSquareDotted -> "dash-square-dotted"
    DashSquareFill -> "dash-square-fill"
    Database -> "database"
    DatabaseAdd -> "database-add"
    DatabaseCheck -> "database-check"
    DatabaseDash -> "database-dash"
    DatabaseDown -> "database-down"
    DatabaseExclamation -> "database-exclamation"
    DatabaseFill -> "database-fill"
    DatabaseFillAdd -> "database-fill-add"
    DatabaseFillCheck -> "database-fill-check"
    DatabaseFillDash -> "database-fill-dash"
    DatabaseFillDown -> "database-fill-down"
    DatabaseFillExclamation -> "database-fill-exclamation"
    DatabaseFillGear -> "database-fill-gear"
    DatabaseFillLock -> "database-fill-lock"
    DatabaseFillSlash -> "database-fill-slash"
    DatabaseFillUp -> "database-fill-up"
    DatabaseFillX -> "database-fill-x"
    DatabaseGear -> "database-gear"
    DatabaseLock -> "database-lock"
    DatabaseSlash -> "database-slash"
    DatabaseUp -> "database-up"
    DatabaseX -> "database-x"
    DeviceHdd -> "device-hdd"
    DeviceHddFill -> "device-hdd-fill"
    DeviceSsd -> "device-ssd"
    DeviceSsdFill -> "device-ssd-fill"
    Diagram2 -> "diagram-2"
    Diagram2Fill -> "diagram-2-fill"
    Diagram3 -> "diagram-3"
    Diagram3Fill -> "diagram-3-fill"
    Diamond -> "diamond"
    DiamondFill -> "diamond-fill"
    DiamondHalf -> "diamond-half"
    Dice1 -> "dice-1"
    Dice1Fill -> "dice-1-fill"
    Dice2 -> "dice-2"
    Dice2Fill -> "dice-2-fill"
    Dice3 -> "dice-3"
    Dice3Fill -> "dice-3-fill"
    Dice4 -> "dice-4"
    Dice4Fill -> "dice-4-fill"
    Dice5 -> "dice-5"
    Dice5Fill -> "dice-5-fill"
    Dice6 -> "dice-6"
    Dice6Fill -> "dice-6-fill"
    Disc -> "disc"
    DiscFill -> "disc-fill"
    Discord -> "discord"
    Display -> "display"
    DisplayFill -> "display-fill"
    Displayport -> "displayport"
    DisplayportFill -> "displayport-fill"
    DistributeHorizontal -> "distribute-horizontal"
    DistributeVertical -> "distribute-vertical"
    DoorClosed -> "door-closed"
    DoorClosedFill -> "door-closed-fill"
    DoorOpen -> "door-open"
    DoorOpenFill -> "door-open-fill"
    Dot -> "dot"
    Download -> "download"
    Dpad -> "dpad"
    DpadFill -> "dpad-fill"
    Dribbble -> "dribbble"
    Dropbox -> "dropbox"
    Droplet -> "droplet"
    DropletFill -> "droplet-fill"
    DropletHalf -> "droplet-half"
    Duffle -> "duffle"
    DuffleFill -> "duffle-fill"
    Ear -> "ear"
    EarFill -> "ear-fill"
    Earbuds -> "earbuds"
    Easel -> "easel"
    EaselFill -> "easel-fill"
    Easel2 -> "easel2"
    Easel2Fill -> "easel2-fill"
    Easel3 -> "easel3"
    Easel3Fill -> "easel3-fill"
    Egg -> "egg"
    EggFill -> "egg-fill"
    EggFried -> "egg-fried"
    Eject -> "eject"
    EjectFill -> "eject-fill"
    EmojiAngry -> "emoji-angry"
    EmojiAngryFill -> "emoji-angry-fill"
    EmojiAstonished -> "emoji-astonished"
    EmojiAstonishedFill -> "emoji-astonished-fill"
    EmojiDizzy -> "emoji-dizzy"
    EmojiDizzyFill -> "emoji-dizzy-fill"
    EmojiExpressionless -> "emoji-expressionless"
    EmojiExpressionlessFill -> "emoji-expressionless-fill"
    EmojiFrown -> "emoji-frown"
    EmojiFrownFill -> "emoji-frown-fill"
    EmojiGrimace -> "emoji-grimace"
    EmojiGrimaceFill -> "emoji-grimace-fill"
    EmojiGrin -> "emoji-grin"
    EmojiGrinFill -> "emoji-grin-fill"
    EmojiHeartEyes -> "emoji-heart-eyes"
    EmojiHeartEyesFill -> "emoji-heart-eyes-fill"
    EmojiKiss -> "emoji-kiss"
    EmojiKissFill -> "emoji-kiss-fill"
    EmojiLaughing -> "emoji-laughing"
    EmojiLaughingFill -> "emoji-laughing-fill"
    EmojiNeutral -> "emoji-neutral"
    EmojiNeutralFill -> "emoji-neutral-fill"
    EmojiSmile -> "emoji-smile"
    EmojiSmileFill -> "emoji-smile-fill"
    EmojiSmileUpsideDown -> "emoji-smile-upside-down"
    EmojiSmileUpsideDownFill -> "emoji-smile-upside-down-fill"
    EmojiSunglasses -> "emoji-sunglasses"
    EmojiSunglassesFill -> "emoji-sunglasses-fill"
    EmojiSurprise -> "emoji-surprise"
    EmojiSurpriseFill -> "emoji-surprise-fill"
    EmojiTear -> "emoji-tear"
    EmojiTearFill -> "emoji-tear-fill"
    EmojiWink -> "emoji-wink"
    EmojiWinkFill -> "emoji-wink-fill"
    Envelope -> "envelope"
    EnvelopeArrowDown -> "envelope-arrow-down"
    EnvelopeArrowDownFill -> "envelope-arrow-down-fill"
    EnvelopeArrowUp -> "envelope-arrow-up"
    EnvelopeArrowUpFill -> "envelope-arrow-up-fill"
    EnvelopeAt -> "envelope-at"
    EnvelopeAtFill -> "envelope-at-fill"
    EnvelopeCheck -> "envelope-check"
    EnvelopeCheckFill -> "envelope-check-fill"
    EnvelopeDash -> "envelope-dash"
    EnvelopeDashFill -> "envelope-dash-fill"
    EnvelopeExclamation -> "envelope-exclamation"
    EnvelopeExclamationFill -> "envelope-exclamation-fill"
    EnvelopeFill -> "envelope-fill"
    EnvelopeHeart -> "envelope-heart"
    EnvelopeHeartFill -> "envelope-heart-fill"
    EnvelopeOpen -> "envelope-open"
    EnvelopeOpenFill -> "envelope-open-fill"
    EnvelopeOpenHeart -> "envelope-open-heart"
    EnvelopeOpenHeartFill -> "envelope-open-heart-fill"
    EnvelopePaper -> "envelope-paper"
    EnvelopePaperFill -> "envelope-paper-fill"
    EnvelopePaperHeart -> "envelope-paper-heart"
    EnvelopePaperHeartFill -> "envelope-paper-heart-fill"
    EnvelopePlus -> "envelope-plus"
    EnvelopePlusFill -> "envelope-plus-fill"
    EnvelopeSlash -> "envelope-slash"
    EnvelopeSlashFill -> "envelope-slash-fill"
    EnvelopeX -> "envelope-x"
    EnvelopeXFill -> "envelope-x-fill"
    Eraser -> "eraser"
    EraserFill -> "eraser-fill"
    Escape -> "escape"
    Ethernet -> "ethernet"
    EvFront -> "ev-front"
    EvFrontFill -> "ev-front-fill"
    EvStation -> "ev-station"
    EvStationFill -> "ev-station-fill"
    Exclamation -> "exclamation"
    ExclamationCircle -> "exclamation-circle"
    ExclamationCircleFill -> "exclamation-circle-fill"
    ExclamationDiamond -> "exclamation-diamond"
    ExclamationDiamondFill -> "exclamation-diamond-fill"
    ExclamationLg -> "exclamation-lg"
    ExclamationOctagon -> "exclamation-octagon"
    ExclamationOctagonFill -> "exclamation-octagon-fill"
    ExclamationSquare -> "exclamation-square"
    ExclamationSquareFill -> "exclamation-square-fill"
    ExclamationTriangle -> "exclamation-triangle"
    ExclamationTriangleFill -> "exclamation-triangle-fill"
    Exclude -> "exclude"
    Explicit -> "explicit"
    ExplicitFill -> "explicit-fill"
    Exposure -> "exposure"
    Eye -> "eye"
    EyeFill -> "eye-fill"
    EyeSlash -> "eye-slash"
    EyeSlashFill -> "eye-slash-fill"
    Eyedropper -> "eyedropper"
    Eyeglasses -> "eyeglasses"
    Facebook -> "facebook"
    Fan -> "fan"
    FastForward -> "fast-forward"
    FastForwardBtn -> "fast-forward-btn"
    FastForwardBtnFill -> "fast-forward-btn-fill"
    FastForwardCircle -> "fast-forward-circle"
    FastForwardCircleFill -> "fast-forward-circle-fill"
    FastForwardFill -> "fast-forward-fill"
    Feather -> "feather"
    Feather2 -> "feather2"
    File -> "file"
    FileArrowDown -> "file-arrow-down"
    FileArrowDownFill -> "file-arrow-down-fill"
    FileArrowUp -> "file-arrow-up"
    FileArrowUpFill -> "file-arrow-up-fill"
    FileBarGraph -> "file-bar-graph"
    FileBarGraphFill -> "file-bar-graph-fill"
    FileBinary -> "file-binary"
    FileBinaryFill -> "file-binary-fill"
    FileBreak -> "file-break"
    FileBreakFill -> "file-break-fill"
    FileCheck -> "file-check"
    FileCheckFill -> "file-check-fill"
    FileCode -> "file-code"
    FileCodeFill -> "file-code-fill"
    FileDiff -> "file-diff"
    FileDiffFill -> "file-diff-fill"
    FileEarmark -> "file-earmark"
    FileEarmarkArrowDown -> "file-earmark-arrow-down"
    FileEarmarkArrowDownFill -> "file-earmark-arrow-down-fill"
    FileEarmarkArrowUp -> "file-earmark-arrow-up"
    FileEarmarkArrowUpFill -> "file-earmark-arrow-up-fill"
    FileEarmarkBarGraph -> "file-earmark-bar-graph"
    FileEarmarkBarGraphFill -> "file-earmark-bar-graph-fill"
    FileEarmarkBinary -> "file-earmark-binary"
    FileEarmarkBinaryFill -> "file-earmark-binary-fill"
    FileEarmarkBreak -> "file-earmark-break"
    FileEarmarkBreakFill -> "file-earmark-break-fill"
    FileEarmarkCheck -> "file-earmark-check"
    FileEarmarkCheckFill -> "file-earmark-check-fill"
    FileEarmarkCode -> "file-earmark-code"
    FileEarmarkCodeFill -> "file-earmark-code-fill"
    FileEarmarkDiff -> "file-earmark-diff"
    FileEarmarkDiffFill -> "file-earmark-diff-fill"
    FileEarmarkEasel -> "file-earmark-easel"
    FileEarmarkEaselFill -> "file-earmark-easel-fill"
    FileEarmarkExcel -> "file-earmark-excel"
    FileEarmarkExcelFill -> "file-earmark-excel-fill"
    FileEarmarkFill -> "file-earmark-fill"
    FileEarmarkFont -> "file-earmark-font"
    FileEarmarkFontFill -> "file-earmark-font-fill"
    FileEarmarkImage -> "file-earmark-image"
    FileEarmarkImageFill -> "file-earmark-image-fill"
    FileEarmarkLock -> "file-earmark-lock"
    FileEarmarkLockFill -> "file-earmark-lock-fill"
    FileEarmarkLock2 -> "file-earmark-lock2"
    FileEarmarkLock2Fill -> "file-earmark-lock2-fill"
    FileEarmarkMedical -> "file-earmark-medical"
    FileEarmarkMedicalFill -> "file-earmark-medical-fill"
    FileEarmarkMinus -> "file-earmark-minus"
    FileEarmarkMinusFill -> "file-earmark-minus-fill"
    FileEarmarkMusic -> "file-earmark-music"
    FileEarmarkMusicFill -> "file-earmark-music-fill"
    FileEarmarkPdf -> "file-earmark-pdf"
    FileEarmarkPdfFill -> "file-earmark-pdf-fill"
    FileEarmarkPerson -> "file-earmark-person"
    FileEarmarkPersonFill -> "file-earmark-person-fill"
    FileEarmarkPlay -> "file-earmark-play"
    FileEarmarkPlayFill -> "file-earmark-play-fill"
    FileEarmarkPlus -> "file-earmark-plus"
    FileEarmarkPlusFill -> "file-earmark-plus-fill"
    FileEarmarkPost -> "file-earmark-post"
    FileEarmarkPostFill -> "file-earmark-post-fill"
    FileEarmarkPpt -> "file-earmark-ppt"
    FileEarmarkPptFill -> "file-earmark-ppt-fill"
    FileEarmarkRichtext -> "file-earmark-richtext"
    FileEarmarkRichtextFill -> "file-earmark-richtext-fill"
    FileEarmarkRuled -> "file-earmark-ruled"
    FileEarmarkRuledFill -> "file-earmark-ruled-fill"
    FileEarmarkSlides -> "file-earmark-slides"
    FileEarmarkSlidesFill -> "file-earmark-slides-fill"
    FileEarmarkSpreadsheet -> "file-earmark-spreadsheet"
    FileEarmarkSpreadsheetFill -> "file-earmark-spreadsheet-fill"
    FileEarmarkText -> "file-earmark-text"
    FileEarmarkTextFill -> "file-earmark-text-fill"
    FileEarmarkWord -> "file-earmark-word"
    FileEarmarkWordFill -> "file-earmark-word-fill"
    FileEarmarkX -> "file-earmark-x"
    FileEarmarkXFill -> "file-earmark-x-fill"
    FileEarmarkZip -> "file-earmark-zip"
    FileEarmarkZipFill -> "file-earmark-zip-fill"
    FileEasel -> "file-easel"
    FileEaselFill -> "file-easel-fill"
    FileExcel -> "file-excel"
    FileExcelFill -> "file-excel-fill"
    FileFill -> "file-fill"
    FileFont -> "file-font"
    FileFontFill -> "file-font-fill"
    FileImage -> "file-image"
    FileImageFill -> "file-image-fill"
    FileLock -> "file-lock"
    FileLockFill -> "file-lock-fill"
    FileLock2 -> "file-lock2"
    FileLock2Fill -> "file-lock2-fill"
    FileMedical -> "file-medical"
    FileMedicalFill -> "file-medical-fill"
    FileMinus -> "file-minus"
    FileMinusFill -> "file-minus-fill"
    FileMusic -> "file-music"
    FileMusicFill -> "file-music-fill"
    FilePdf -> "file-pdf"
    FilePdfFill -> "file-pdf-fill"
    FilePerson -> "file-person"
    FilePersonFill -> "file-person-fill"
    FilePlay -> "file-play"
    FilePlayFill -> "file-play-fill"
    FilePlus -> "file-plus"
    FilePlusFill -> "file-plus-fill"
    FilePost -> "file-post"
    FilePostFill -> "file-post-fill"
    FilePpt -> "file-ppt"
    FilePptFill -> "file-ppt-fill"
    FileRichtext -> "file-richtext"
    FileRichtextFill -> "file-richtext-fill"
    FileRuled -> "file-ruled"
    FileRuledFill -> "file-ruled-fill"
    FileSlides -> "file-slides"
    FileSlidesFill -> "file-slides-fill"
    FileSpreadsheet -> "file-spreadsheet"
    FileSpreadsheetFill -> "file-spreadsheet-fill"
    FileText -> "file-text"
    FileTextFill -> "file-text-fill"
    FileWord -> "file-word"
    FileWordFill -> "file-word-fill"
    FileX -> "file-x"
    FileXFill -> "file-x-fill"
    FileZip -> "file-zip"
    FileZipFill -> "file-zip-fill"
    Files -> "files"
    FilesAlt -> "files-alt"
    FiletypeAac -> "filetype-aac"
    FiletypeAi -> "filetype-ai"
    FiletypeBmp -> "filetype-bmp"
    FiletypeCs -> "filetype-cs"
    FiletypeCss -> "filetype-css"
    FiletypeCsv -> "filetype-csv"
    FiletypeDoc -> "filetype-doc"
    FiletypeDocx -> "filetype-docx"
    FiletypeExe -> "filetype-exe"
    FiletypeGif -> "filetype-gif"
    FiletypeHeic -> "filetype-heic"
    FiletypeHtml -> "filetype-html"
    FiletypeJava -> "filetype-java"
    FiletypeJpg -> "filetype-jpg"
    FiletypeJs -> "filetype-js"
    FiletypeJson -> "filetype-json"
    FiletypeJsx -> "filetype-jsx"
    FiletypeKey -> "filetype-key"
    FiletypeM4p -> "filetype-m4p"
    FiletypeMd -> "filetype-md"
    FiletypeMdx -> "filetype-mdx"
    FiletypeMov -> "filetype-mov"
    FiletypeMp3 -> "filetype-mp3"
    FiletypeMp4 -> "filetype-mp4"
    FiletypeOtf -> "filetype-otf"
    FiletypePdf -> "filetype-pdf"
    FiletypePhp -> "filetype-php"
    FiletypePng -> "filetype-png"
    FiletypePpt -> "filetype-ppt"
    FiletypePptx -> "filetype-pptx"
    FiletypePsd -> "filetype-psd"
    FiletypePy -> "filetype-py"
    FiletypeRaw -> "filetype-raw"
    FiletypeRb -> "filetype-rb"
    FiletypeSass -> "filetype-sass"
    FiletypeScss -> "filetype-scss"
    FiletypeSh -> "filetype-sh"
    FiletypeSql -> "filetype-sql"
    FiletypeSvg -> "filetype-svg"
    FiletypeTiff -> "filetype-tiff"
    FiletypeTsx -> "filetype-tsx"
    FiletypeTtf -> "filetype-ttf"
    FiletypeTxt -> "filetype-txt"
    FiletypeWav -> "filetype-wav"
    FiletypeWoff -> "filetype-woff"
    FiletypeXls -> "filetype-xls"
    FiletypeXlsx -> "filetype-xlsx"
    FiletypeXml -> "filetype-xml"
    FiletypeYml -> "filetype-yml"
    Film -> "film"
    Filter -> "filter"
    FilterCircle -> "filter-circle"
    FilterCircleFill -> "filter-circle-fill"
    FilterLeft -> "filter-left"
    FilterRight -> "filter-right"
    FilterSquare -> "filter-square"
    FilterSquareFill -> "filter-square-fill"
    Fingerprint -> "fingerprint"
    Fire -> "fire"
    Flag -> "flag"
    FlagFill -> "flag-fill"
    Floppy -> "floppy"
    FloppyFill -> "floppy-fill"
    Floppy2 -> "floppy2"
    Floppy2Fill -> "floppy2-fill"
    Flower1 -> "flower1"
    Flower2 -> "flower2"
    Flower3 -> "flower3"
    Folder -> "folder"
    FolderCheck -> "folder-check"
    FolderFill -> "folder-fill"
    FolderMinus -> "folder-minus"
    FolderPlus -> "folder-plus"
    FolderSymlink -> "folder-symlink"
    FolderSymlinkFill -> "folder-symlink-fill"
    FolderX -> "folder-x"
    Folder2 -> "folder2"
    Folder2Open -> "folder2-open"
    Fonts -> "fonts"
    Forward -> "forward"
    ForwardFill -> "forward-fill"
    Front -> "front"
    FuelPump -> "fuel-pump"
    FuelPumpDiesel -> "fuel-pump-diesel"
    FuelPumpDieselFill -> "fuel-pump-diesel-fill"
    FuelPumpFill -> "fuel-pump-fill"
    Fullscreen -> "fullscreen"
    FullscreenExit -> "fullscreen-exit"
    Funnel -> "funnel"
    FunnelFill -> "funnel-fill"
    Gear -> "gear"
    GearFill -> "gear-fill"
    GearWide -> "gear-wide"
    GearWideConnected -> "gear-wide-connected"
    Gem -> "gem"
    GenderAmbiguous -> "gender-ambiguous"
    GenderFemale -> "gender-female"
    GenderMale -> "gender-male"
    GenderNeuter -> "gender-neuter"
    GenderTrans -> "gender-trans"
    Geo -> "geo"
    GeoAlt -> "geo-alt"
    GeoAltFill -> "geo-alt-fill"
    GeoFill -> "geo-fill"
    Gift -> "gift"
    GiftFill -> "gift-fill"
    Git -> "git"
    Github -> "github"
    Gitlab -> "gitlab"
    Globe -> "globe"
    GlobeAmericas -> "globe-americas"
    GlobeAsiaAustralia -> "globe-asia-australia"
    GlobeCentralSouthAsia -> "globe-central-south-asia"
    GlobeEuropeAfrica -> "globe-europe-africa"
    Globe2 -> "globe2"
    Google -> "google"
    GooglePlay -> "google-play"
    GpuCard -> "gpu-card"
    GraphDown -> "graph-down"
    GraphDownArrow -> "graph-down-arrow"
    GraphUp -> "graph-up"
    GraphUpArrow -> "graph-up-arrow"
    Grid -> "grid"
    Grid1x2 -> "grid-1x2"
    Grid1x2Fill -> "grid-1x2-fill"
    Grid3x2 -> "grid-3x2"
    Grid3x2Gap -> "grid-3x2-gap"
    Grid3x2GapFill -> "grid-3x2-gap-fill"
    Grid3x3 -> "grid-3x3"
    Grid3x3Gap -> "grid-3x3-gap"
    Grid3x3GapFill -> "grid-3x3-gap-fill"
    GridFill -> "grid-fill"
    GripHorizontal -> "grip-horizontal"
    GripVertical -> "grip-vertical"
    HCircle -> "h-circle"
    HCircleFill -> "h-circle-fill"
    HSquare -> "h-square"
    HSquareFill -> "h-square-fill"
    Hammer -> "hammer"
    HandIndex -> "hand-index"
    HandIndexFill -> "hand-index-fill"
    HandIndexThumb -> "hand-index-thumb"
    HandIndexThumbFill -> "hand-index-thumb-fill"
    HandThumbsDown -> "hand-thumbs-down"
    HandThumbsDownFill -> "hand-thumbs-down-fill"
    HandThumbsUp -> "hand-thumbs-up"
    HandThumbsUpFill -> "hand-thumbs-up-fill"
    Handbag -> "handbag"
    HandbagFill -> "handbag-fill"
    Hash -> "hash"
    Hdd -> "hdd"
    HddFill -> "hdd-fill"
    HddNetwork -> "hdd-network"
    HddNetworkFill -> "hdd-network-fill"
    HddRack -> "hdd-rack"
    HddRackFill -> "hdd-rack-fill"
    HddStack -> "hdd-stack"
    HddStackFill -> "hdd-stack-fill"
    Hdmi -> "hdmi"
    HdmiFill -> "hdmi-fill"
    Headphones -> "headphones"
    Headset -> "headset"
    HeadsetVr -> "headset-vr"
    Heart -> "heart"
    HeartArrow -> "heart-arrow"
    HeartFill -> "heart-fill"
    HeartHalf -> "heart-half"
    HeartPulse -> "heart-pulse"
    HeartPulseFill -> "heart-pulse-fill"
    Heartbreak -> "heartbreak"
    HeartbreakFill -> "heartbreak-fill"
    Hearts -> "hearts"
    Heptagon -> "heptagon"
    HeptagonFill -> "heptagon-fill"
    HeptagonHalf -> "heptagon-half"
    Hexagon -> "hexagon"
    HexagonFill -> "hexagon-fill"
    HexagonHalf -> "hexagon-half"
    Highlighter -> "highlighter"
    Highlights -> "highlights"
    Hospital -> "hospital"
    HospitalFill -> "hospital-fill"
    Hourglass -> "hourglass"
    HourglassBottom -> "hourglass-bottom"
    HourglassSplit -> "hourglass-split"
    HourglassTop -> "hourglass-top"
    House -> "house"
    HouseAdd -> "house-add"
    HouseAddFill -> "house-add-fill"
    HouseCheck -> "house-check"
    HouseCheckFill -> "house-check-fill"
    HouseDash -> "house-dash"
    HouseDashFill -> "house-dash-fill"
    HouseDoor -> "house-door"
    HouseDoorFill -> "house-door-fill"
    HouseDown -> "house-down"
    HouseDownFill -> "house-down-fill"
    HouseExclamation -> "house-exclamation"
    HouseExclamationFill -> "house-exclamation-fill"
    HouseFill -> "house-fill"
    HouseGear -> "house-gear"
    HouseGearFill -> "house-gear-fill"
    HouseHeart -> "house-heart"
    HouseHeartFill -> "house-heart-fill"
    HouseLock -> "house-lock"
    HouseLockFill -> "house-lock-fill"
    HouseSlash -> "house-slash"
    HouseSlashFill -> "house-slash-fill"
    HouseUp -> "house-up"
    HouseUpFill -> "house-up-fill"
    HouseX -> "house-x"
    HouseXFill -> "house-x-fill"
    Houses -> "houses"
    HousesFill -> "houses-fill"
    Hr -> "hr"
    Hurricane -> "hurricane"
    Hypnotize -> "hypnotize"
    Image -> "image"
    ImageAlt -> "image-alt"
    ImageFill -> "image-fill"
    Images -> "images"
    Inbox -> "inbox"
    InboxFill -> "inbox-fill"
    Inboxes -> "inboxes"
    InboxesFill -> "inboxes-fill"
    Incognito -> "incognito"
    Indent -> "indent"
    Infinity -> "infinity"
    Info -> "info"
    InfoCircle -> "info-circle"
    InfoCircleFill -> "info-circle-fill"
    InfoLg -> "info-lg"
    InfoSquare -> "info-square"
    InfoSquareFill -> "info-square-fill"
    InputCursor -> "input-cursor"
    InputCursorText -> "input-cursor-text"
    Instagram -> "instagram"
    Intersect -> "intersect"
    Journal -> "journal"
    JournalAlbum -> "journal-album"
    JournalArrowDown -> "journal-arrow-down"
    JournalArrowUp -> "journal-arrow-up"
    JournalBookmark -> "journal-bookmark"
    JournalBookmarkFill -> "journal-bookmark-fill"
    JournalCheck -> "journal-check"
    JournalCode -> "journal-code"
    JournalMedical -> "journal-medical"
    JournalMinus -> "journal-minus"
    JournalPlus -> "journal-plus"
    JournalRichtext -> "journal-richtext"
    JournalText -> "journal-text"
    JournalX -> "journal-x"
    Journals -> "journals"
    Joystick -> "joystick"
    Justify -> "justify"
    JustifyLeft -> "justify-left"
    JustifyRight -> "justify-right"
    Kanban -> "kanban"
    KanbanFill -> "kanban-fill"
    Key -> "key"
    KeyFill -> "key-fill"
    Keyboard -> "keyboard"
    KeyboardFill -> "keyboard-fill"
    Ladder -> "ladder"
    Lamp -> "lamp"
    LampFill -> "lamp-fill"
    Laptop -> "laptop"
    LaptopFill -> "laptop-fill"
    LayerBackward -> "layer-backward"
    LayerForward -> "layer-forward"
    Layers -> "layers"
    LayersFill -> "layers-fill"
    LayersHalf -> "layers-half"
    LayoutSidebar -> "layout-sidebar"
    LayoutSidebarInset -> "layout-sidebar-inset"
    LayoutSidebarInsetReverse -> "layout-sidebar-inset-reverse"
    LayoutSidebarReverse -> "layout-sidebar-reverse"
    LayoutSplit -> "layout-split"
    LayoutTextSidebar -> "layout-text-sidebar"
    LayoutTextSidebarReverse -> "layout-text-sidebar-reverse"
    LayoutTextWindow -> "layout-text-window"
    LayoutTextWindowReverse -> "layout-text-window-reverse"
    LayoutThreeColumns -> "layout-three-columns"
    LayoutWtf -> "layout-wtf"
    LifePreserver -> "life-preserver"
    Lightbulb -> "lightbulb"
    LightbulbFill -> "lightbulb-fill"
    LightbulbOff -> "lightbulb-off"
    LightbulbOffFill -> "lightbulb-off-fill"
    Lightning -> "lightning"
    LightningCharge -> "lightning-charge"
    LightningChargeFill -> "lightning-charge-fill"
    LightningFill -> "lightning-fill"
    Line -> "line"
    Link -> "link"
    Link45deg -> "link-45deg"
    Linkedin -> "linkedin"
    List -> "list"
    ListCheck -> "list-check"
    ListColumns -> "list-columns"
    ListColumnsReverse -> "list-columns-reverse"
    ListNested -> "list-nested"
    ListOl -> "list-ol"
    ListStars -> "list-stars"
    ListTask -> "list-task"
    ListUl -> "list-ul"
    Lock -> "lock"
    LockFill -> "lock-fill"
    Luggage -> "luggage"
    LuggageFill -> "luggage-fill"
    Lungs -> "lungs"
    LungsFill -> "lungs-fill"
    Magic -> "magic"
    Magnet -> "magnet"
    MagnetFill -> "magnet-fill"
    Mailbox -> "mailbox"
    MailboxFlag -> "mailbox-flag"
    Mailbox2 -> "mailbox2"
    Mailbox2Flag -> "mailbox2-flag"
    Map -> "map"
    MapFill -> "map-fill"
    Markdown -> "markdown"
    MarkdownFill -> "markdown-fill"
    MarkerTip -> "marker-tip"
    Mask -> "mask"
    Mastodon -> "mastodon"
    Medium -> "medium"
    Megaphone -> "megaphone"
    MegaphoneFill -> "megaphone-fill"
    Memory -> "memory"
    MenuApp -> "menu-app"
    MenuAppFill -> "menu-app-fill"
    MenuButton -> "menu-button"
    MenuButtonFill -> "menu-button-fill"
    MenuButtonWide -> "menu-button-wide"
    MenuButtonWideFill -> "menu-button-wide-fill"
    MenuDown -> "menu-down"
    MenuUp -> "menu-up"
    Messenger -> "messenger"
    Meta -> "meta"
    Mic -> "mic"
    MicFill -> "mic-fill"
    MicMute -> "mic-mute"
    MicMuteFill -> "mic-mute-fill"
    Microsoft -> "microsoft"
    MicrosoftTeams -> "microsoft-teams"
    Minecart -> "minecart"
    MinecartLoaded -> "minecart-loaded"
    Modem -> "modem"
    ModemFill -> "modem-fill"
    Moisture -> "moisture"
    Moon -> "moon"
    MoonFill -> "moon-fill"
    MoonStars -> "moon-stars"
    MoonStarsFill -> "moon-stars-fill"
    Mortarboard -> "mortarboard"
    MortarboardFill -> "mortarboard-fill"
    Motherboard -> "motherboard"
    MotherboardFill -> "motherboard-fill"
    Mouse -> "mouse"
    MouseFill -> "mouse-fill"
    Mouse2 -> "mouse2"
    Mouse2Fill -> "mouse2-fill"
    Mouse3 -> "mouse3"
    Mouse3Fill -> "mouse3-fill"
    MusicNote -> "music-note"
    MusicNoteBeamed -> "music-note-beamed"
    MusicNoteList -> "music-note-list"
    MusicPlayer -> "music-player"
    MusicPlayerFill -> "music-player-fill"
    Newspaper -> "newspaper"
    NintendoSwitch -> "nintendo-switch"
    NodeMinus -> "node-minus"
    NodeMinusFill -> "node-minus-fill"
    NodePlus -> "node-plus"
    NodePlusFill -> "node-plus-fill"
    NoiseReduction -> "noise-reduction"
    Nut -> "nut"
    NutFill -> "nut-fill"
    Nvidia -> "nvidia"
    Nvme -> "nvme"
    NvmeFill -> "nvme-fill"
    Octagon -> "octagon"
    OctagonFill -> "octagon-fill"
    OctagonHalf -> "octagon-half"
    Opencollective -> "opencollective"
    OpticalAudio -> "optical-audio"
    OpticalAudioFill -> "optical-audio-fill"
    Option -> "option"
    Outlet -> "outlet"
    PCircle -> "p-circle"
    PCircleFill -> "p-circle-fill"
    PSquare -> "p-square"
    PSquareFill -> "p-square-fill"
    PaintBucket -> "paint-bucket"
    Palette -> "palette"
    PaletteFill -> "palette-fill"
    Palette2 -> "palette2"
    Paperclip -> "paperclip"
    Paragraph -> "paragraph"
    Pass -> "pass"
    PassFill -> "pass-fill"
    Passport -> "passport"
    PassportFill -> "passport-fill"
    PatchCheck -> "patch-check"
    PatchCheckFill -> "patch-check-fill"
    PatchExclamation -> "patch-exclamation"
    PatchExclamationFill -> "patch-exclamation-fill"
    PatchMinus -> "patch-minus"
    PatchMinusFill -> "patch-minus-fill"
    PatchPlus -> "patch-plus"
    PatchPlusFill -> "patch-plus-fill"
    PatchQuestion -> "patch-question"
    PatchQuestionFill -> "patch-question-fill"
    Pause -> "pause"
    PauseBtn -> "pause-btn"
    PauseBtnFill -> "pause-btn-fill"
    PauseCircle -> "pause-circle"
    PauseCircleFill -> "pause-circle-fill"
    PauseFill -> "pause-fill"
    Paypal -> "paypal"
    Pc -> "pc"
    PcDisplay -> "pc-display"
    PcDisplayHorizontal -> "pc-display-horizontal"
    PcHorizontal -> "pc-horizontal"
    PciCard -> "pci-card"
    PciCardNetwork -> "pci-card-network"
    PciCardSound -> "pci-card-sound"
    Peace -> "peace"
    PeaceFill -> "peace-fill"
    Pen -> "pen"
    PenFill -> "pen-fill"
    Pencil -> "pencil"
    PencilFill -> "pencil-fill"
    PencilSquare -> "pencil-square"
    Pentagon -> "pentagon"
    PentagonFill -> "pentagon-fill"
    PentagonHalf -> "pentagon-half"
    People -> "people"
    PeopleFill -> "people-fill"
    Percent -> "percent"
    Person -> "person"
    PersonAdd -> "person-add"
    PersonArmsUp -> "person-arms-up"
    PersonBadge -> "person-badge"
    PersonBadgeFill -> "person-badge-fill"
    PersonBoundingBox -> "person-bounding-box"
    PersonCheck -> "person-check"
    PersonCheckFill -> "person-check-fill"
    PersonCircle -> "person-circle"
    PersonDash -> "person-dash"
    PersonDashFill -> "person-dash-fill"
    PersonDown -> "person-down"
    PersonExclamation -> "person-exclamation"
    PersonFill -> "person-fill"
    PersonFillAdd -> "person-fill-add"
    PersonFillCheck -> "person-fill-check"
    PersonFillDash -> "person-fill-dash"
    PersonFillDown -> "person-fill-down"
    PersonFillExclamation -> "person-fill-exclamation"
    PersonFillGear -> "person-fill-gear"
    PersonFillLock -> "person-fill-lock"
    PersonFillSlash -> "person-fill-slash"
    PersonFillUp -> "person-fill-up"
    PersonFillX -> "person-fill-x"
    PersonGear -> "person-gear"
    PersonHeart -> "person-heart"
    PersonHearts -> "person-hearts"
    PersonLinesFill -> "person-lines-fill"
    PersonLock -> "person-lock"
    PersonPlus -> "person-plus"
    PersonPlusFill -> "person-plus-fill"
    PersonRaisedHand -> "person-raised-hand"
    PersonRolodex -> "person-rolodex"
    PersonSlash -> "person-slash"
    PersonSquare -> "person-square"
    PersonStanding -> "person-standing"
    PersonStandingDress -> "person-standing-dress"
    PersonUp -> "person-up"
    PersonVcard -> "person-vcard"
    PersonVcardFill -> "person-vcard-fill"
    PersonVideo -> "person-video"
    PersonVideo2 -> "person-video2"
    PersonVideo3 -> "person-video3"
    PersonWalking -> "person-walking"
    PersonWheelchair -> "person-wheelchair"
    PersonWorkspace -> "person-workspace"
    PersonX -> "person-x"
    PersonXFill -> "person-x-fill"
    Phone -> "phone"
    PhoneFill -> "phone-fill"
    PhoneFlip -> "phone-flip"
    PhoneLandscape -> "phone-landscape"
    PhoneLandscapeFill -> "phone-landscape-fill"
    PhoneVibrate -> "phone-vibrate"
    PhoneVibrateFill -> "phone-vibrate-fill"
    PieChart -> "pie-chart"
    PieChartFill -> "pie-chart-fill"
    PiggyBank -> "piggy-bank"
    PiggyBankFill -> "piggy-bank-fill"
    Pin -> "pin"
    PinAngle -> "pin-angle"
    PinAngleFill -> "pin-angle-fill"
    PinFill -> "pin-fill"
    PinMap -> "pin-map"
    PinMapFill -> "pin-map-fill"
    Pinterest -> "pinterest"
    Pip -> "pip"
    PipFill -> "pip-fill"
    Play -> "play"
    PlayBtn -> "play-btn"
    PlayBtnFill -> "play-btn-fill"
    PlayCircle -> "play-circle"
    PlayCircleFill -> "play-circle-fill"
    PlayFill -> "play-fill"
    Playstation -> "playstation"
    Plug -> "plug"
    PlugFill -> "plug-fill"
    Plugin -> "plugin"
    Plus -> "plus"
    PlusCircle -> "plus-circle"
    PlusCircleDotted -> "plus-circle-dotted"
    PlusCircleFill -> "plus-circle-fill"
    PlusLg -> "plus-lg"
    PlusSlashMinus -> "plus-slash-minus"
    PlusSquare -> "plus-square"
    PlusSquareDotted -> "plus-square-dotted"
    PlusSquareFill -> "plus-square-fill"
    Postage -> "postage"
    PostageFill -> "postage-fill"
    PostageHeart -> "postage-heart"
    PostageHeartFill -> "postage-heart-fill"
    Postcard -> "postcard"
    PostcardFill -> "postcard-fill"
    PostcardHeart -> "postcard-heart"
    PostcardHeartFill -> "postcard-heart-fill"
    Power -> "power"
    Prescription -> "prescription"
    Prescription2 -> "prescription2"
    Printer -> "printer"
    PrinterFill -> "printer-fill"
    Projector -> "projector"
    ProjectorFill -> "projector-fill"
    Puzzle -> "puzzle"
    PuzzleFill -> "puzzle-fill"
    QrCode -> "qr-code"
    QrCodeScan -> "qr-code-scan"
    Question -> "question"
    QuestionCircle -> "question-circle"
    QuestionCircleFill -> "question-circle-fill"
    QuestionDiamond -> "question-diamond"
    QuestionDiamondFill -> "question-diamond-fill"
    QuestionLg -> "question-lg"
    QuestionOctagon -> "question-octagon"
    QuestionOctagonFill -> "question-octagon-fill"
    QuestionSquare -> "question-square"
    QuestionSquareFill -> "question-square-fill"
    Quora -> "quora"
    Quote -> "quote"
    RCircle -> "r-circle"
    RCircleFill -> "r-circle-fill"
    RSquare -> "r-square"
    RSquareFill -> "r-square-fill"
    Radar -> "radar"
    Radioactive -> "radioactive"
    Rainbow -> "rainbow"
    Receipt -> "receipt"
    ReceiptCutoff -> "receipt-cutoff"
    Reception0 -> "reception-0"
    Reception1 -> "reception-1"
    Reception2 -> "reception-2"
    Reception3 -> "reception-3"
    Reception4 -> "reception-4"
    Record -> "record"
    RecordBtn -> "record-btn"
    RecordBtnFill -> "record-btn-fill"
    RecordCircle -> "record-circle"
    RecordCircleFill -> "record-circle-fill"
    RecordFill -> "record-fill"
    Record2 -> "record2"
    Record2Fill -> "record2-fill"
    Recycle -> "recycle"
    Reddit -> "reddit"
    Regex -> "regex"
    Repeat -> "repeat"
    Repeat1 -> "repeat-1"
    Reply -> "reply"
    ReplyAll -> "reply-all"
    ReplyAllFill -> "reply-all-fill"
    ReplyFill -> "reply-fill"
    Rewind -> "rewind"
    RewindBtn -> "rewind-btn"
    RewindBtnFill -> "rewind-btn-fill"
    RewindCircle -> "rewind-circle"
    RewindCircleFill -> "rewind-circle-fill"
    RewindFill -> "rewind-fill"
    Robot -> "robot"
    Rocket -> "rocket"
    RocketFill -> "rocket-fill"
    RocketTakeoff -> "rocket-takeoff"
    RocketTakeoffFill -> "rocket-takeoff-fill"
    Router -> "router"
    RouterFill -> "router-fill"
    Rss -> "rss"
    RssFill -> "rss-fill"
    Rulers -> "rulers"
    Safe -> "safe"
    SafeFill -> "safe-fill"
    Safe2 -> "safe2"
    Safe2Fill -> "safe2-fill"
    Save -> "save"
    SaveFill -> "save-fill"
    Save2 -> "save2"
    Save2Fill -> "save2-fill"
    Scissors -> "scissors"
    Scooter -> "scooter"
    Screwdriver -> "screwdriver"
    SdCard -> "sd-card"
    SdCardFill -> "sd-card-fill"
    Search -> "search"
    SearchHeart -> "search-heart"
    SearchHeartFill -> "search-heart-fill"
    SegmentedNav -> "segmented-nav"
    Send -> "send"
    SendArrowDown -> "send-arrow-down"
    SendArrowDownFill -> "send-arrow-down-fill"
    SendArrowUp -> "send-arrow-up"
    SendArrowUpFill -> "send-arrow-up-fill"
    SendCheck -> "send-check"
    SendCheckFill -> "send-check-fill"
    SendDash -> "send-dash"
    SendDashFill -> "send-dash-fill"
    SendExclamation -> "send-exclamation"
    SendExclamationFill -> "send-exclamation-fill"
    SendFill -> "send-fill"
    SendPlus -> "send-plus"
    SendPlusFill -> "send-plus-fill"
    SendSlash -> "send-slash"
    SendSlashFill -> "send-slash-fill"
    SendX -> "send-x"
    SendXFill -> "send-x-fill"
    Server -> "server"
    Shadows -> "shadows"
    Share -> "share"
    ShareFill -> "share-fill"
    Shield -> "shield"
    ShieldCheck -> "shield-check"
    ShieldExclamation -> "shield-exclamation"
    ShieldFill -> "shield-fill"
    ShieldFillCheck -> "shield-fill-check"
    ShieldFillExclamation -> "shield-fill-exclamation"
    ShieldFillMinus -> "shield-fill-minus"
    ShieldFillPlus -> "shield-fill-plus"
    ShieldFillX -> "shield-fill-x"
    ShieldLock -> "shield-lock"
    ShieldLockFill -> "shield-lock-fill"
    ShieldMinus -> "shield-minus"
    ShieldPlus -> "shield-plus"
    ShieldShaded -> "shield-shaded"
    ShieldSlash -> "shield-slash"
    ShieldSlashFill -> "shield-slash-fill"
    ShieldX -> "shield-x"
    Shift -> "shift"
    ShiftFill -> "shift-fill"
    Shop -> "shop"
    ShopWindow -> "shop-window"
    Shuffle -> "shuffle"
    SignDeadEnd -> "sign-dead-end"
    SignDeadEndFill -> "sign-dead-end-fill"
    SignDoNotEnter -> "sign-do-not-enter"
    SignDoNotEnterFill -> "sign-do-not-enter-fill"
    SignIntersection -> "sign-intersection"
    SignIntersectionFill -> "sign-intersection-fill"
    SignIntersectionSide -> "sign-intersection-side"
    SignIntersectionSideFill -> "sign-intersection-side-fill"
    SignIntersectionT -> "sign-intersection-t"
    SignIntersectionTFill -> "sign-intersection-t-fill"
    SignIntersectionY -> "sign-intersection-y"
    SignIntersectionYFill -> "sign-intersection-y-fill"
    SignMergeLeft -> "sign-merge-left"
    SignMergeLeftFill -> "sign-merge-left-fill"
    SignMergeRight -> "sign-merge-right"
    SignMergeRightFill -> "sign-merge-right-fill"
    SignNoLeftTurn -> "sign-no-left-turn"
    SignNoLeftTurnFill -> "sign-no-left-turn-fill"
    SignNoParking -> "sign-no-parking"
    SignNoParkingFill -> "sign-no-parking-fill"
    SignNoRightTurn -> "sign-no-right-turn"
    SignNoRightTurnFill -> "sign-no-right-turn-fill"
    SignRailroad -> "sign-railroad"
    SignRailroadFill -> "sign-railroad-fill"
    SignStop -> "sign-stop"
    SignStopFill -> "sign-stop-fill"
    SignStopLights -> "sign-stop-lights"
    SignStopLightsFill -> "sign-stop-lights-fill"
    SignTurnLeft -> "sign-turn-left"
    SignTurnLeftFill -> "sign-turn-left-fill"
    SignTurnRight -> "sign-turn-right"
    SignTurnRightFill -> "sign-turn-right-fill"
    SignTurnSlightLeft -> "sign-turn-slight-left"
    SignTurnSlightLeftFill -> "sign-turn-slight-left-fill"
    SignTurnSlightRight -> "sign-turn-slight-right"
    SignTurnSlightRightFill -> "sign-turn-slight-right-fill"
    SignYield -> "sign-yield"
    SignYieldFill -> "sign-yield-fill"
    Signal -> "signal"
    Signpost -> "signpost"
    Signpost2 -> "signpost-2"
    Signpost2Fill -> "signpost-2-fill"
    SignpostFill -> "signpost-fill"
    SignpostSplit -> "signpost-split"
    SignpostSplitFill -> "signpost-split-fill"
    Sim -> "sim"
    SimFill -> "sim-fill"
    SimSlash -> "sim-slash"
    SimSlashFill -> "sim-slash-fill"
    SinaWeibo -> "sina-weibo"
    SkipBackward -> "skip-backward"
    SkipBackwardBtn -> "skip-backward-btn"
    SkipBackwardBtnFill -> "skip-backward-btn-fill"
    SkipBackwardCircle -> "skip-backward-circle"
    SkipBackwardCircleFill -> "skip-backward-circle-fill"
    SkipBackwardFill -> "skip-backward-fill"
    SkipEnd -> "skip-end"
    SkipEndBtn -> "skip-end-btn"
    SkipEndBtnFill -> "skip-end-btn-fill"
    SkipEndCircle -> "skip-end-circle"
    SkipEndCircleFill -> "skip-end-circle-fill"
    SkipEndFill -> "skip-end-fill"
    SkipForward -> "skip-forward"
    SkipForwardBtn -> "skip-forward-btn"
    SkipForwardBtnFill -> "skip-forward-btn-fill"
    SkipForwardCircle -> "skip-forward-circle"
    SkipForwardCircleFill -> "skip-forward-circle-fill"
    SkipForwardFill -> "skip-forward-fill"
    SkipStart -> "skip-start"
    SkipStartBtn -> "skip-start-btn"
    SkipStartBtnFill -> "skip-start-btn-fill"
    SkipStartCircle -> "skip-start-circle"
    SkipStartCircleFill -> "skip-start-circle-fill"
    SkipStartFill -> "skip-start-fill"
    Skype -> "skype"
    Slack -> "slack"
    Slash -> "slash"
    SlashCircle -> "slash-circle"
    SlashCircleFill -> "slash-circle-fill"
    SlashLg -> "slash-lg"
    SlashSquare -> "slash-square"
    SlashSquareFill -> "slash-square-fill"
    Sliders -> "sliders"
    Sliders2 -> "sliders2"
    Sliders2Vertical -> "sliders2-vertical"
    Smartwatch -> "smartwatch"
    Snapchat -> "snapchat"
    Snow -> "snow"
    Snow2 -> "snow2"
    Snow3 -> "snow3"
    SortAlphaDown -> "sort-alpha-down"
    SortAlphaDownAlt -> "sort-alpha-down-alt"
    SortAlphaUp -> "sort-alpha-up"
    SortAlphaUpAlt -> "sort-alpha-up-alt"
    SortDown -> "sort-down"
    SortDownAlt -> "sort-down-alt"
    SortNumericDown -> "sort-numeric-down"
    SortNumericDownAlt -> "sort-numeric-down-alt"
    SortNumericUp -> "sort-numeric-up"
    SortNumericUpAlt -> "sort-numeric-up-alt"
    SortUp -> "sort-up"
    SortUpAlt -> "sort-up-alt"
    Soundwave -> "soundwave"
    Sourceforge -> "sourceforge"
    Speaker -> "speaker"
    SpeakerFill -> "speaker-fill"
    Speedometer -> "speedometer"
    Speedometer2 -> "speedometer2"
    Spellcheck -> "spellcheck"
    Spotify -> "spotify"
    Square -> "square"
    SquareFill -> "square-fill"
    SquareHalf -> "square-half"
    Stack -> "stack"
    StackOverflow -> "stack-overflow"
    Star -> "star"
    StarFill -> "star-fill"
    StarHalf -> "star-half"
    Stars -> "stars"
    Steam -> "steam"
    Stickies -> "stickies"
    StickiesFill -> "stickies-fill"
    Sticky -> "sticky"
    StickyFill -> "sticky-fill"
    Stop -> "stop"
    StopBtn -> "stop-btn"
    StopBtnFill -> "stop-btn-fill"
    StopCircle -> "stop-circle"
    StopCircleFill -> "stop-circle-fill"
    StopFill -> "stop-fill"
    Stoplights -> "stoplights"
    StoplightsFill -> "stoplights-fill"
    Stopwatch -> "stopwatch"
    StopwatchFill -> "stopwatch-fill"
    Strava -> "strava"
    Stripe -> "stripe"
    Subscript -> "subscript"
    Substack -> "substack"
    Subtract -> "subtract"
    SuitClub -> "suit-club"
    SuitClubFill -> "suit-club-fill"
    SuitDiamond -> "suit-diamond"
    SuitDiamondFill -> "suit-diamond-fill"
    SuitHeart -> "suit-heart"
    SuitHeartFill -> "suit-heart-fill"
    SuitSpade -> "suit-spade"
    SuitSpadeFill -> "suit-spade-fill"
    Suitcase -> "suitcase"
    SuitcaseFill -> "suitcase-fill"
    SuitcaseLg -> "suitcase-lg"
    SuitcaseLgFill -> "suitcase-lg-fill"
    Suitcase2 -> "suitcase2"
    Suitcase2Fill -> "suitcase2-fill"
    Sun -> "sun"
    SunFill -> "sun-fill"
    Sunglasses -> "sunglasses"
    Sunrise -> "sunrise"
    SunriseFill -> "sunrise-fill"
    Sunset -> "sunset"
    SunsetFill -> "sunset-fill"
    Superscript -> "superscript"
    SymmetryHorizontal -> "symmetry-horizontal"
    SymmetryVertical -> "symmetry-vertical"
    Table -> "table"
    Tablet -> "tablet"
    TabletFill -> "tablet-fill"
    TabletLandscape -> "tablet-landscape"
    TabletLandscapeFill -> "tablet-landscape-fill"
    Tag -> "tag"
    TagFill -> "tag-fill"
    Tags -> "tags"
    TagsFill -> "tags-fill"
    TaxiFront -> "taxi-front"
    TaxiFrontFill -> "taxi-front-fill"
    Telegram -> "telegram"
    Telephone -> "telephone"
    TelephoneFill -> "telephone-fill"
    TelephoneForward -> "telephone-forward"
    TelephoneForwardFill -> "telephone-forward-fill"
    TelephoneInbound -> "telephone-inbound"
    TelephoneInboundFill -> "telephone-inbound-fill"
    TelephoneMinus -> "telephone-minus"
    TelephoneMinusFill -> "telephone-minus-fill"
    TelephoneOutbound -> "telephone-outbound"
    TelephoneOutboundFill -> "telephone-outbound-fill"
    TelephonePlus -> "telephone-plus"
    TelephonePlusFill -> "telephone-plus-fill"
    TelephoneX -> "telephone-x"
    TelephoneXFill -> "telephone-x-fill"
    TencentQq -> "tencent-qq"
    Terminal -> "terminal"
    TerminalDash -> "terminal-dash"
    TerminalFill -> "terminal-fill"
    TerminalPlus -> "terminal-plus"
    TerminalSplit -> "terminal-split"
    TerminalX -> "terminal-x"
    TextCenter -> "text-center"
    TextIndentLeft -> "text-indent-left"
    TextIndentRight -> "text-indent-right"
    TextLeft -> "text-left"
    TextParagraph -> "text-paragraph"
    TextRight -> "text-right"
    TextWrap -> "text-wrap"
    Textarea -> "textarea"
    TextareaResize -> "textarea-resize"
    TextareaT -> "textarea-t"
    Thermometer -> "thermometer"
    ThermometerHalf -> "thermometer-half"
    ThermometerHigh -> "thermometer-high"
    ThermometerLow -> "thermometer-low"
    ThermometerSnow -> "thermometer-snow"
    ThermometerSun -> "thermometer-sun"
    Threads -> "threads"
    ThreadsFill -> "threads-fill"
    ThreeDots -> "three-dots"
    ThreeDotsVertical -> "three-dots-vertical"
    Thunderbolt -> "thunderbolt"
    ThunderboltFill -> "thunderbolt-fill"
    Ticket -> "ticket"
    TicketDetailed -> "ticket-detailed"
    TicketDetailedFill -> "ticket-detailed-fill"
    TicketFill -> "ticket-fill"
    TicketPerforated -> "ticket-perforated"
    TicketPerforatedFill -> "ticket-perforated-fill"
    Tiktok -> "tiktok"
    ToggleOff -> "toggle-off"
    ToggleOn -> "toggle-on"
    Toggle2Off -> "toggle2-off"
    Toggle2On -> "toggle2-on"
    Toggles -> "toggles"
    Toggles2 -> "toggles2"
    Tools -> "tools"
    Tornado -> "tornado"
    TrainFreightFront -> "train-freight-front"
    TrainFreightFrontFill -> "train-freight-front-fill"
    TrainFront -> "train-front"
    TrainFrontFill -> "train-front-fill"
    TrainLightrailFront -> "train-lightrail-front"
    TrainLightrailFrontFill -> "train-lightrail-front-fill"
    Translate -> "translate"
    Transparency -> "transparency"
    Trash -> "trash"
    TrashFill -> "trash-fill"
    Trash2 -> "trash2"
    Trash2Fill -> "trash2-fill"
    Trash3 -> "trash3"
    Trash3Fill -> "trash3-fill"
    Tree -> "tree"
    TreeFill -> "tree-fill"
    Trello -> "trello"
    Triangle -> "triangle"
    TriangleFill -> "triangle-fill"
    TriangleHalf -> "triangle-half"
    Trophy -> "trophy"
    TrophyFill -> "trophy-fill"
    TropicalStorm -> "tropical-storm"
    Truck -> "truck"
    TruckFlatbed -> "truck-flatbed"
    TruckFront -> "truck-front"
    TruckFrontFill -> "truck-front-fill"
    Tsunami -> "tsunami"
    Tv -> "tv"
    TvFill -> "tv-fill"
    Twitch -> "twitch"
    Twitter -> "twitter"
    TwitterX -> "twitter-x"
    Type -> "type"
    TypeBold -> "type-bold"
    TypeH1 -> "type-h1"
    TypeH2 -> "type-h2"
    TypeH3 -> "type-h3"
    TypeH4 -> "type-h4"
    TypeH5 -> "type-h5"
    TypeH6 -> "type-h6"
    TypeItalic -> "type-italic"
    TypeStrikethrough -> "type-strikethrough"
    TypeUnderline -> "type-underline"
    Ubuntu -> "ubuntu"
    UiChecks -> "ui-checks"
    UiChecksGrid -> "ui-checks-grid"
    UiRadios -> "ui-radios"
    UiRadiosGrid -> "ui-radios-grid"
    Umbrella -> "umbrella"
    UmbrellaFill -> "umbrella-fill"
    Unindent -> "unindent"
    Union -> "union"
    Unity -> "unity"
    UniversalAccess -> "universal-access"
    UniversalAccessCircle -> "universal-access-circle"
    Unlock -> "unlock"
    UnlockFill -> "unlock-fill"
    Upc -> "upc"
    UpcScan -> "upc-scan"
    Upload -> "upload"
    Usb -> "usb"
    UsbC -> "usb-c"
    UsbCFill -> "usb-c-fill"
    UsbDrive -> "usb-drive"
    UsbDriveFill -> "usb-drive-fill"
    UsbFill -> "usb-fill"
    UsbMicro -> "usb-micro"
    UsbMicroFill -> "usb-micro-fill"
    UsbMini -> "usb-mini"
    UsbMiniFill -> "usb-mini-fill"
    UsbPlug -> "usb-plug"
    UsbPlugFill -> "usb-plug-fill"
    UsbSymbol -> "usb-symbol"
    Valentine -> "valentine"
    Valentine2 -> "valentine2"
    VectorPen -> "vector-pen"
    ViewList -> "view-list"
    ViewStacked -> "view-stacked"
    Vignette -> "vignette"
    Vimeo -> "vimeo"
    Vinyl -> "vinyl"
    VinylFill -> "vinyl-fill"
    Virus -> "virus"
    Virus2 -> "virus2"
    Voicemail -> "voicemail"
    VolumeDown -> "volume-down"
    VolumeDownFill -> "volume-down-fill"
    VolumeMute -> "volume-mute"
    VolumeMuteFill -> "volume-mute-fill"
    VolumeOff -> "volume-off"
    VolumeOffFill -> "volume-off-fill"
    VolumeUp -> "volume-up"
    VolumeUpFill -> "volume-up-fill"
    Vr -> "vr"
    Wallet -> "wallet"
    WalletFill -> "wallet-fill"
    Wallet2 -> "wallet2"
    Watch -> "watch"
    Water -> "water"
    Webcam -> "webcam"
    WebcamFill -> "webcam-fill"
    Wechat -> "wechat"
    Whatsapp -> "whatsapp"
    Wifi -> "wifi"
    Wifi1 -> "wifi-1"
    Wifi2 -> "wifi-2"
    WifiOff -> "wifi-off"
    Wikipedia -> "wikipedia"
    Wind -> "wind"
    Window -> "window"
    WindowDash -> "window-dash"
    WindowDesktop -> "window-desktop"
    WindowDock -> "window-dock"
    WindowFullscreen -> "window-fullscreen"
    WindowPlus -> "window-plus"
    WindowSidebar -> "window-sidebar"
    WindowSplit -> "window-split"
    WindowStack -> "window-stack"
    WindowX -> "window-x"
    Windows -> "windows"
    Wordpress -> "wordpress"
    Wrench -> "wrench"
    WrenchAdjustable -> "wrench-adjustable"
    WrenchAdjustableCircle -> "wrench-adjustable-circle"
    WrenchAdjustableCircleFill -> "wrench-adjustable-circle-fill"
    X -> "x"
    XCircle -> "x-circle"
    XCircleFill -> "x-circle-fill"
    XDiamond -> "x-diamond"
    XDiamondFill -> "x-diamond-fill"
    XLg -> "x-lg"
    XOctagon -> "x-octagon"
    XOctagonFill -> "x-octagon-fill"
    XSquare -> "x-square"
    XSquareFill -> "x-square-fill"
    Xbox -> "xbox"
    Yelp -> "yelp"
    YinYang -> "yin-yang"
    Youtube -> "youtube"
    ZoomIn -> "zoom-in"
    ZoomOut -> "zoom-out"
  }
}

fn item_type_decoder(value: Dynamic) -> Result(IconType, List(DecodeError)) {
  dynamic.string(value)
  |> result.then(fn(value: String) {
    case value {
      "0-circle" -> Ok(Num0Circle)
      "0-circle-fill" -> Ok(Num0CircleFill)
      "0-square" -> Ok(Num0Square)
      "0-square-fill" -> Ok(Num0SquareFill)
      "1-circle" -> Ok(Num1Circle)
      "1-circle-fill" -> Ok(Num1CircleFill)
      "1-square" -> Ok(Num1Square)
      "1-square-fill" -> Ok(Num1SquareFill)
      "123" -> Ok(Num123)
      "2-circle" -> Ok(Num2Circle)
      "2-circle-fill" -> Ok(Num2CircleFill)
      "2-square" -> Ok(Num2Square)
      "2-square-fill" -> Ok(Num2SquareFill)
      "3-circle" -> Ok(Num3Circle)
      "3-circle-fill" -> Ok(Num3CircleFill)
      "3-square" -> Ok(Num3Square)
      "3-square-fill" -> Ok(Num3SquareFill)
      "4-circle" -> Ok(Num4Circle)
      "4-circle-fill" -> Ok(Num4CircleFill)
      "4-square" -> Ok(Num4Square)
      "4-square-fill" -> Ok(Num4SquareFill)
      "5-circle" -> Ok(Num5Circle)
      "5-circle-fill" -> Ok(Num5CircleFill)
      "5-square" -> Ok(Num5Square)
      "5-square-fill" -> Ok(Num5SquareFill)
      "6-circle" -> Ok(Num6Circle)
      "6-circle-fill" -> Ok(Num6CircleFill)
      "6-square" -> Ok(Num6Square)
      "6-square-fill" -> Ok(Num6SquareFill)
      "7-circle" -> Ok(Num7Circle)
      "7-circle-fill" -> Ok(Num7CircleFill)
      "7-square" -> Ok(Num7Square)
      "7-square-fill" -> Ok(Num7SquareFill)
      "8-circle" -> Ok(Num8Circle)
      "8-circle-fill" -> Ok(Num8CircleFill)
      "8-square" -> Ok(Num8Square)
      "8-square-fill" -> Ok(Num8SquareFill)
      "9-circle" -> Ok(Num9Circle)
      "9-circle-fill" -> Ok(Num9CircleFill)
      "9-square" -> Ok(Num9Square)
      "9-square-fill" -> Ok(Num9SquareFill)
      "activity" -> Ok(Activity)
      "airplane" -> Ok(Airplane)
      "airplane-engines" -> Ok(AirplaneEngines)
      "airplane-engines-fill" -> Ok(AirplaneEnginesFill)
      "airplane-fill" -> Ok(AirplaneFill)
      "alarm" -> Ok(Alarm)
      "alarm-fill" -> Ok(AlarmFill)
      "alexa" -> Ok(Alexa)
      "align-bottom" -> Ok(AlignBottom)
      "align-center" -> Ok(AlignCenter)
      "align-end" -> Ok(AlignEnd)
      "align-middle" -> Ok(AlignMiddle)
      "align-start" -> Ok(AlignStart)
      "align-top" -> Ok(AlignTop)
      "alipay" -> Ok(Alipay)
      "alphabet" -> Ok(Alphabet)
      "alphabet-uppercase" -> Ok(AlphabetUppercase)
      "alt" -> Ok(Alt)
      "amazon" -> Ok(Amazon)
      "amd" -> Ok(Amd)
      "android" -> Ok(Android)
      "android2" -> Ok(Android2)
      "app" -> Ok(App)
      "app-indicator" -> Ok(AppIndicator)
      "apple" -> Ok(Apple)
      "archive" -> Ok(Archive)
      "archive-fill" -> Ok(ArchiveFill)
      "arrow-90deg-down" -> Ok(Arrow90degDown)
      "arrow-90deg-left" -> Ok(Arrow90degLeft)
      "arrow-90deg-right" -> Ok(Arrow90degRight)
      "arrow-90deg-up" -> Ok(Arrow90degUp)
      "arrow-bar-down" -> Ok(ArrowBarDown)
      "arrow-bar-left" -> Ok(ArrowBarLeft)
      "arrow-bar-right" -> Ok(ArrowBarRight)
      "arrow-bar-up" -> Ok(ArrowBarUp)
      "arrow-clockwise" -> Ok(ArrowClockwise)
      "arrow-counterclockwise" -> Ok(ArrowCounterclockwise)
      "arrow-down" -> Ok(ArrowDown)
      "arrow-down-circle" -> Ok(ArrowDownCircle)
      "arrow-down-circle-fill" -> Ok(ArrowDownCircleFill)
      "arrow-down-left" -> Ok(ArrowDownLeft)
      "arrow-down-left-circle" -> Ok(ArrowDownLeftCircle)
      "arrow-down-left-circle-fill" -> Ok(ArrowDownLeftCircleFill)
      "arrow-down-left-square" -> Ok(ArrowDownLeftSquare)
      "arrow-down-left-square-fill" -> Ok(ArrowDownLeftSquareFill)
      "arrow-down-right" -> Ok(ArrowDownRight)
      "arrow-down-right-circle" -> Ok(ArrowDownRightCircle)
      "arrow-down-right-circle-fill" -> Ok(ArrowDownRightCircleFill)
      "arrow-down-right-square" -> Ok(ArrowDownRightSquare)
      "arrow-down-right-square-fill" -> Ok(ArrowDownRightSquareFill)
      "arrow-down-short" -> Ok(ArrowDownShort)
      "arrow-down-square" -> Ok(ArrowDownSquare)
      "arrow-down-square-fill" -> Ok(ArrowDownSquareFill)
      "arrow-down-up" -> Ok(ArrowDownUp)
      "arrow-left" -> Ok(ArrowLeft)
      "arrow-left-circle" -> Ok(ArrowLeftCircle)
      "arrow-left-circle-fill" -> Ok(ArrowLeftCircleFill)
      "arrow-left-right" -> Ok(ArrowLeftRight)
      "arrow-left-short" -> Ok(ArrowLeftShort)
      "arrow-left-square" -> Ok(ArrowLeftSquare)
      "arrow-left-square-fill" -> Ok(ArrowLeftSquareFill)
      "arrow-repeat" -> Ok(ArrowRepeat)
      "arrow-return-left" -> Ok(ArrowReturnLeft)
      "arrow-return-right" -> Ok(ArrowReturnRight)
      "arrow-right" -> Ok(ArrowRight)
      "arrow-right-circle" -> Ok(ArrowRightCircle)
      "arrow-right-circle-fill" -> Ok(ArrowRightCircleFill)
      "arrow-right-short" -> Ok(ArrowRightShort)
      "arrow-right-square" -> Ok(ArrowRightSquare)
      "arrow-right-square-fill" -> Ok(ArrowRightSquareFill)
      "arrow-through-heart" -> Ok(ArrowThroughHeart)
      "arrow-through-heart-fill" -> Ok(ArrowThroughHeartFill)
      "arrow-up" -> Ok(ArrowUp)
      "arrow-up-circle" -> Ok(ArrowUpCircle)
      "arrow-up-circle-fill" -> Ok(ArrowUpCircleFill)
      "arrow-up-left" -> Ok(ArrowUpLeft)
      "arrow-up-left-circle" -> Ok(ArrowUpLeftCircle)
      "arrow-up-left-circle-fill" -> Ok(ArrowUpLeftCircleFill)
      "arrow-up-left-square" -> Ok(ArrowUpLeftSquare)
      "arrow-up-left-square-fill" -> Ok(ArrowUpLeftSquareFill)
      "arrow-up-right" -> Ok(ArrowUpRight)
      "arrow-up-right-circle" -> Ok(ArrowUpRightCircle)
      "arrow-up-right-circle-fill" -> Ok(ArrowUpRightCircleFill)
      "arrow-up-right-square" -> Ok(ArrowUpRightSquare)
      "arrow-up-right-square-fill" -> Ok(ArrowUpRightSquareFill)
      "arrow-up-short" -> Ok(ArrowUpShort)
      "arrow-up-square" -> Ok(ArrowUpSquare)
      "arrow-up-square-fill" -> Ok(ArrowUpSquareFill)
      "arrows" -> Ok(Arrows)
      "arrows-angle-contract" -> Ok(ArrowsAngleContract)
      "arrows-angle-expand" -> Ok(ArrowsAngleExpand)
      "arrows-collapse" -> Ok(ArrowsCollapse)
      "arrows-collapse-vertical" -> Ok(ArrowsCollapseVertical)
      "arrows-expand" -> Ok(ArrowsExpand)
      "arrows-expand-vertical" -> Ok(ArrowsExpandVertical)
      "arrows-fullscreen" -> Ok(ArrowsFullscreen)
      "arrows-move" -> Ok(ArrowsMove)
      "arrows-vertical" -> Ok(ArrowsVertical)
      "aspect-ratio" -> Ok(AspectRatio)
      "aspect-ratio-fill" -> Ok(AspectRatioFill)
      "asterisk" -> Ok(Asterisk)
      "at" -> Ok(At)
      "award" -> Ok(Award)
      "award-fill" -> Ok(AwardFill)
      "back" -> Ok(Back)
      "backpack" -> Ok(Backpack)
      "backpack-fill" -> Ok(BackpackFill)
      "backpack2" -> Ok(Backpack2)
      "backpack2-fill" -> Ok(Backpack2Fill)
      "backpack3" -> Ok(Backpack3)
      "backpack3-fill" -> Ok(Backpack3Fill)
      "backpack4" -> Ok(Backpack4)
      "backpack4-fill" -> Ok(Backpack4Fill)
      "backspace" -> Ok(Backspace)
      "backspace-fill" -> Ok(BackspaceFill)
      "backspace-reverse" -> Ok(BackspaceReverse)
      "backspace-reverse-fill" -> Ok(BackspaceReverseFill)
      "badge-3d" -> Ok(Badge3d)
      "badge-3d-fill" -> Ok(Badge3dFill)
      "badge-4k" -> Ok(Badge4k)
      "badge-4k-fill" -> Ok(Badge4kFill)
      "badge-8k" -> Ok(Badge8k)
      "badge-8k-fill" -> Ok(Badge8kFill)
      "badge-ad" -> Ok(BadgeAd)
      "badge-ad-fill" -> Ok(BadgeAdFill)
      "badge-ar" -> Ok(BadgeAr)
      "badge-ar-fill" -> Ok(BadgeArFill)
      "badge-cc" -> Ok(BadgeCc)
      "badge-cc-fill" -> Ok(BadgeCcFill)
      "badge-hd" -> Ok(BadgeHd)
      "badge-hd-fill" -> Ok(BadgeHdFill)
      "badge-sd" -> Ok(BadgeSd)
      "badge-sd-fill" -> Ok(BadgeSdFill)
      "badge-tm" -> Ok(BadgeTm)
      "badge-tm-fill" -> Ok(BadgeTmFill)
      "badge-vo" -> Ok(BadgeVo)
      "badge-vo-fill" -> Ok(BadgeVoFill)
      "badge-vr" -> Ok(BadgeVr)
      "badge-vr-fill" -> Ok(BadgeVrFill)
      "badge-wc" -> Ok(BadgeWc)
      "badge-wc-fill" -> Ok(BadgeWcFill)
      "bag" -> Ok(Bag)
      "bag-check" -> Ok(BagCheck)
      "bag-check-fill" -> Ok(BagCheckFill)
      "bag-dash" -> Ok(BagDash)
      "bag-dash-fill" -> Ok(BagDashFill)
      "bag-fill" -> Ok(BagFill)
      "bag-heart" -> Ok(BagHeart)
      "bag-heart-fill" -> Ok(BagHeartFill)
      "bag-plus" -> Ok(BagPlus)
      "bag-plus-fill" -> Ok(BagPlusFill)
      "bag-x" -> Ok(BagX)
      "bag-x-fill" -> Ok(BagXFill)
      "balloon" -> Ok(Balloon)
      "balloon-fill" -> Ok(BalloonFill)
      "balloon-heart" -> Ok(BalloonHeart)
      "balloon-heart-fill" -> Ok(BalloonHeartFill)
      "ban" -> Ok(Ban)
      "ban-fill" -> Ok(BanFill)
      "bandaid" -> Ok(Bandaid)
      "bandaid-fill" -> Ok(BandaidFill)
      "bank" -> Ok(Bank)
      "bank2" -> Ok(Bank2)
      "bar-chart" -> Ok(BarChart)
      "bar-chart-fill" -> Ok(BarChartFill)
      "bar-chart-line" -> Ok(BarChartLine)
      "bar-chart-line-fill" -> Ok(BarChartLineFill)
      "bar-chart-steps" -> Ok(BarChartSteps)
      "basket" -> Ok(Basket)
      "basket-fill" -> Ok(BasketFill)
      "basket2" -> Ok(Basket2)
      "basket2-fill" -> Ok(Basket2Fill)
      "basket3" -> Ok(Basket3)
      "basket3-fill" -> Ok(Basket3Fill)
      "battery" -> Ok(Battery)
      "battery-charging" -> Ok(BatteryCharging)
      "battery-full" -> Ok(BatteryFull)
      "battery-half" -> Ok(BatteryHalf)
      "behance" -> Ok(Behance)
      "bell" -> Ok(Bell)
      "bell-fill" -> Ok(BellFill)
      "bell-slash" -> Ok(BellSlash)
      "bell-slash-fill" -> Ok(BellSlashFill)
      "bezier" -> Ok(Bezier)
      "bezier2" -> Ok(Bezier2)
      "bicycle" -> Ok(Bicycle)
      "bing" -> Ok(Bing)
      "binoculars" -> Ok(Binoculars)
      "binoculars-fill" -> Ok(BinocularsFill)
      "blockquote-left" -> Ok(BlockquoteLeft)
      "blockquote-right" -> Ok(BlockquoteRight)
      "bluetooth" -> Ok(Bluetooth)
      "body-text" -> Ok(BodyText)
      "book" -> Ok(Book)
      "book-fill" -> Ok(BookFill)
      "book-half" -> Ok(BookHalf)
      "bookmark" -> Ok(Bookmark)
      "bookmark-check" -> Ok(BookmarkCheck)
      "bookmark-check-fill" -> Ok(BookmarkCheckFill)
      "bookmark-dash" -> Ok(BookmarkDash)
      "bookmark-dash-fill" -> Ok(BookmarkDashFill)
      "bookmark-fill" -> Ok(BookmarkFill)
      "bookmark-heart" -> Ok(BookmarkHeart)
      "bookmark-heart-fill" -> Ok(BookmarkHeartFill)
      "bookmark-plus" -> Ok(BookmarkPlus)
      "bookmark-plus-fill" -> Ok(BookmarkPlusFill)
      "bookmark-star" -> Ok(BookmarkStar)
      "bookmark-star-fill" -> Ok(BookmarkStarFill)
      "bookmark-x" -> Ok(BookmarkX)
      "bookmark-x-fill" -> Ok(BookmarkXFill)
      "bookmarks" -> Ok(Bookmarks)
      "bookmarks-fill" -> Ok(BookmarksFill)
      "bookshelf" -> Ok(Bookshelf)
      "boombox" -> Ok(Boombox)
      "boombox-fill" -> Ok(BoomboxFill)
      "bootstrap" -> Ok(Bootstrap)
      "bootstrap-fill" -> Ok(BootstrapFill)
      "bootstrap-reboot" -> Ok(BootstrapReboot)
      "border" -> Ok(Border)
      "border-all" -> Ok(BorderAll)
      "border-bottom" -> Ok(BorderBottom)
      "border-center" -> Ok(BorderCenter)
      "border-inner" -> Ok(BorderInner)
      "border-left" -> Ok(BorderLeft)
      "border-middle" -> Ok(BorderMiddle)
      "border-outer" -> Ok(BorderOuter)
      "border-right" -> Ok(BorderRight)
      "border-style" -> Ok(BorderStyle)
      "border-top" -> Ok(BorderTop)
      "border-width" -> Ok(BorderWidth)
      "bounding-box" -> Ok(BoundingBox)
      "bounding-box-circles" -> Ok(BoundingBoxCircles)
      "box" -> Ok(Box)
      "box-arrow-down" -> Ok(BoxArrowDown)
      "box-arrow-down-left" -> Ok(BoxArrowDownLeft)
      "box-arrow-down-right" -> Ok(BoxArrowDownRight)
      "box-arrow-in-down" -> Ok(BoxArrowInDown)
      "box-arrow-in-down-left" -> Ok(BoxArrowInDownLeft)
      "box-arrow-in-down-right" -> Ok(BoxArrowInDownRight)
      "box-arrow-in-left" -> Ok(BoxArrowInLeft)
      "box-arrow-in-right" -> Ok(BoxArrowInRight)
      "box-arrow-in-up" -> Ok(BoxArrowInUp)
      "box-arrow-in-up-left" -> Ok(BoxArrowInUpLeft)
      "box-arrow-in-up-right" -> Ok(BoxArrowInUpRight)
      "box-arrow-left" -> Ok(BoxArrowLeft)
      "box-arrow-right" -> Ok(BoxArrowRight)
      "box-arrow-up" -> Ok(BoxArrowUp)
      "box-arrow-up-left" -> Ok(BoxArrowUpLeft)
      "box-arrow-up-right" -> Ok(BoxArrowUpRight)
      "box-fill" -> Ok(BoxFill)
      "box-seam" -> Ok(BoxSeam)
      "box-seam-fill" -> Ok(BoxSeamFill)
      "box2" -> Ok(Box2)
      "box2-fill" -> Ok(Box2Fill)
      "box2-heart" -> Ok(Box2Heart)
      "box2-heart-fill" -> Ok(Box2HeartFill)
      "boxes" -> Ok(Boxes)
      "braces" -> Ok(Braces)
      "braces-asterisk" -> Ok(BracesAsterisk)
      "bricks" -> Ok(Bricks)
      "briefcase" -> Ok(Briefcase)
      "briefcase-fill" -> Ok(BriefcaseFill)
      "brightness-alt-high" -> Ok(BrightnessAltHigh)
      "brightness-alt-high-fill" -> Ok(BrightnessAltHighFill)
      "brightness-alt-low" -> Ok(BrightnessAltLow)
      "brightness-alt-low-fill" -> Ok(BrightnessAltLowFill)
      "brightness-high" -> Ok(BrightnessHigh)
      "brightness-high-fill" -> Ok(BrightnessHighFill)
      "brightness-low" -> Ok(BrightnessLow)
      "brightness-low-fill" -> Ok(BrightnessLowFill)
      "brilliance" -> Ok(Brilliance)
      "broadcast" -> Ok(Broadcast)
      "broadcast-pin" -> Ok(BroadcastPin)
      "browser-chrome" -> Ok(BrowserChrome)
      "browser-edge" -> Ok(BrowserEdge)
      "browser-firefox" -> Ok(BrowserFirefox)
      "browser-safari" -> Ok(BrowserSafari)
      "brush" -> Ok(Brush)
      "brush-fill" -> Ok(BrushFill)
      "bucket" -> Ok(Bucket)
      "bucket-fill" -> Ok(BucketFill)
      "bug" -> Ok(Bug)
      "bug-fill" -> Ok(BugFill)
      "building" -> Ok(Building)
      "building-add" -> Ok(BuildingAdd)
      "building-check" -> Ok(BuildingCheck)
      "building-dash" -> Ok(BuildingDash)
      "building-down" -> Ok(BuildingDown)
      "building-exclamation" -> Ok(BuildingExclamation)
      "building-fill" -> Ok(BuildingFill)
      "building-fill-add" -> Ok(BuildingFillAdd)
      "building-fill-check" -> Ok(BuildingFillCheck)
      "building-fill-dash" -> Ok(BuildingFillDash)
      "building-fill-down" -> Ok(BuildingFillDown)
      "building-fill-exclamation" -> Ok(BuildingFillExclamation)
      "building-fill-gear" -> Ok(BuildingFillGear)
      "building-fill-lock" -> Ok(BuildingFillLock)
      "building-fill-slash" -> Ok(BuildingFillSlash)
      "building-fill-up" -> Ok(BuildingFillUp)
      "building-fill-x" -> Ok(BuildingFillX)
      "building-gear" -> Ok(BuildingGear)
      "building-lock" -> Ok(BuildingLock)
      "building-slash" -> Ok(BuildingSlash)
      "building-up" -> Ok(BuildingUp)
      "building-x" -> Ok(BuildingX)
      "buildings" -> Ok(Buildings)
      "buildings-fill" -> Ok(BuildingsFill)
      "bullseye" -> Ok(Bullseye)
      "bus-front" -> Ok(BusFront)
      "bus-front-fill" -> Ok(BusFrontFill)
      "c-circle" -> Ok(CCircle)
      "c-circle-fill" -> Ok(CCircleFill)
      "c-square" -> Ok(CSquare)
      "c-square-fill" -> Ok(CSquareFill)
      "cake" -> Ok(Cake)
      "cake-fill" -> Ok(CakeFill)
      "cake2" -> Ok(Cake2)
      "cake2-fill" -> Ok(Cake2Fill)
      "calculator" -> Ok(Calculator)
      "calculator-fill" -> Ok(CalculatorFill)
      "calendar" -> Ok(Calendar)
      "calendar-check" -> Ok(CalendarCheck)
      "calendar-check-fill" -> Ok(CalendarCheckFill)
      "calendar-date" -> Ok(CalendarDate)
      "calendar-date-fill" -> Ok(CalendarDateFill)
      "calendar-day" -> Ok(CalendarDay)
      "calendar-day-fill" -> Ok(CalendarDayFill)
      "calendar-event" -> Ok(CalendarEvent)
      "calendar-event-fill" -> Ok(CalendarEventFill)
      "calendar-fill" -> Ok(CalendarFill)
      "calendar-heart" -> Ok(CalendarHeart)
      "calendar-heart-fill" -> Ok(CalendarHeartFill)
      "calendar-minus" -> Ok(CalendarMinus)
      "calendar-minus-fill" -> Ok(CalendarMinusFill)
      "calendar-month" -> Ok(CalendarMonth)
      "calendar-month-fill" -> Ok(CalendarMonthFill)
      "calendar-plus" -> Ok(CalendarPlus)
      "calendar-plus-fill" -> Ok(CalendarPlusFill)
      "calendar-range" -> Ok(CalendarRange)
      "calendar-range-fill" -> Ok(CalendarRangeFill)
      "calendar-week" -> Ok(CalendarWeek)
      "calendar-week-fill" -> Ok(CalendarWeekFill)
      "calendar-x" -> Ok(CalendarX)
      "calendar-x-fill" -> Ok(CalendarXFill)
      "calendar2" -> Ok(Calendar2)
      "calendar2-check" -> Ok(Calendar2Check)
      "calendar2-check-fill" -> Ok(Calendar2CheckFill)
      "calendar2-date" -> Ok(Calendar2Date)
      "calendar2-date-fill" -> Ok(Calendar2DateFill)
      "calendar2-day" -> Ok(Calendar2Day)
      "calendar2-day-fill" -> Ok(Calendar2DayFill)
      "calendar2-event" -> Ok(Calendar2Event)
      "calendar2-event-fill" -> Ok(Calendar2EventFill)
      "calendar2-fill" -> Ok(Calendar2Fill)
      "calendar2-heart" -> Ok(Calendar2Heart)
      "calendar2-heart-fill" -> Ok(Calendar2HeartFill)
      "calendar2-minus" -> Ok(Calendar2Minus)
      "calendar2-minus-fill" -> Ok(Calendar2MinusFill)
      "calendar2-month" -> Ok(Calendar2Month)
      "calendar2-month-fill" -> Ok(Calendar2MonthFill)
      "calendar2-plus" -> Ok(Calendar2Plus)
      "calendar2-plus-fill" -> Ok(Calendar2PlusFill)
      "calendar2-range" -> Ok(Calendar2Range)
      "calendar2-range-fill" -> Ok(Calendar2RangeFill)
      "calendar2-week" -> Ok(Calendar2Week)
      "calendar2-week-fill" -> Ok(Calendar2WeekFill)
      "calendar2-x" -> Ok(Calendar2X)
      "calendar2-x-fill" -> Ok(Calendar2XFill)
      "calendar3" -> Ok(Calendar3)
      "calendar3-event" -> Ok(Calendar3Event)
      "calendar3-event-fill" -> Ok(Calendar3EventFill)
      "calendar3-fill" -> Ok(Calendar3Fill)
      "calendar3-range" -> Ok(Calendar3Range)
      "calendar3-range-fill" -> Ok(Calendar3RangeFill)
      "calendar3-week" -> Ok(Calendar3Week)
      "calendar3-week-fill" -> Ok(Calendar3WeekFill)
      "calendar4" -> Ok(Calendar4)
      "calendar4-event" -> Ok(Calendar4Event)
      "calendar4-range" -> Ok(Calendar4Range)
      "calendar4-week" -> Ok(Calendar4Week)
      "camera" -> Ok(Camera)
      "camera-fill" -> Ok(CameraFill)
      "camera-reels" -> Ok(CameraReels)
      "camera-reels-fill" -> Ok(CameraReelsFill)
      "camera-video" -> Ok(CameraVideo)
      "camera-video-fill" -> Ok(CameraVideoFill)
      "camera-video-off" -> Ok(CameraVideoOff)
      "camera-video-off-fill" -> Ok(CameraVideoOffFill)
      "camera2" -> Ok(Camera2)
      "capslock" -> Ok(Capslock)
      "capslock-fill" -> Ok(CapslockFill)
      "capsule" -> Ok(Capsule)
      "capsule-pill" -> Ok(CapsulePill)
      "car-front" -> Ok(CarFront)
      "car-front-fill" -> Ok(CarFrontFill)
      "card-checklist" -> Ok(CardChecklist)
      "card-heading" -> Ok(CardHeading)
      "card-image" -> Ok(CardImage)
      "card-list" -> Ok(CardList)
      "card-text" -> Ok(CardText)
      "caret-down" -> Ok(CaretDown)
      "caret-down-fill" -> Ok(CaretDownFill)
      "caret-down-square" -> Ok(CaretDownSquare)
      "caret-down-square-fill" -> Ok(CaretDownSquareFill)
      "caret-left" -> Ok(CaretLeft)
      "caret-left-fill" -> Ok(CaretLeftFill)
      "caret-left-square" -> Ok(CaretLeftSquare)
      "caret-left-square-fill" -> Ok(CaretLeftSquareFill)
      "caret-right" -> Ok(CaretRight)
      "caret-right-fill" -> Ok(CaretRightFill)
      "caret-right-square" -> Ok(CaretRightSquare)
      "caret-right-square-fill" -> Ok(CaretRightSquareFill)
      "caret-up" -> Ok(CaretUp)
      "caret-up-fill" -> Ok(CaretUpFill)
      "caret-up-square" -> Ok(CaretUpSquare)
      "caret-up-square-fill" -> Ok(CaretUpSquareFill)
      "cart" -> Ok(Cart)
      "cart-check" -> Ok(CartCheck)
      "cart-check-fill" -> Ok(CartCheckFill)
      "cart-dash" -> Ok(CartDash)
      "cart-dash-fill" -> Ok(CartDashFill)
      "cart-fill" -> Ok(CartFill)
      "cart-plus" -> Ok(CartPlus)
      "cart-plus-fill" -> Ok(CartPlusFill)
      "cart-x" -> Ok(CartX)
      "cart-x-fill" -> Ok(CartXFill)
      "cart2" -> Ok(Cart2)
      "cart3" -> Ok(Cart3)
      "cart4" -> Ok(Cart4)
      "cash" -> Ok(Cash)
      "cash-coin" -> Ok(CashCoin)
      "cash-stack" -> Ok(CashStack)
      "cassette" -> Ok(Cassette)
      "cassette-fill" -> Ok(CassetteFill)
      "cast" -> Ok(Cast)
      "cc-circle" -> Ok(CcCircle)
      "cc-circle-fill" -> Ok(CcCircleFill)
      "cc-square" -> Ok(CcSquare)
      "cc-square-fill" -> Ok(CcSquareFill)
      "chat" -> Ok(Chat)
      "chat-dots" -> Ok(ChatDots)
      "chat-dots-fill" -> Ok(ChatDotsFill)
      "chat-fill" -> Ok(ChatFill)
      "chat-heart" -> Ok(ChatHeart)
      "chat-heart-fill" -> Ok(ChatHeartFill)
      "chat-left" -> Ok(ChatLeft)
      "chat-left-dots" -> Ok(ChatLeftDots)
      "chat-left-dots-fill" -> Ok(ChatLeftDotsFill)
      "chat-left-fill" -> Ok(ChatLeftFill)
      "chat-left-heart" -> Ok(ChatLeftHeart)
      "chat-left-heart-fill" -> Ok(ChatLeftHeartFill)
      "chat-left-quote" -> Ok(ChatLeftQuote)
      "chat-left-quote-fill" -> Ok(ChatLeftQuoteFill)
      "chat-left-text" -> Ok(ChatLeftText)
      "chat-left-text-fill" -> Ok(ChatLeftTextFill)
      "chat-quote" -> Ok(ChatQuote)
      "chat-quote-fill" -> Ok(ChatQuoteFill)
      "chat-right" -> Ok(ChatRight)
      "chat-right-dots" -> Ok(ChatRightDots)
      "chat-right-dots-fill" -> Ok(ChatRightDotsFill)
      "chat-right-fill" -> Ok(ChatRightFill)
      "chat-right-heart" -> Ok(ChatRightHeart)
      "chat-right-heart-fill" -> Ok(ChatRightHeartFill)
      "chat-right-quote" -> Ok(ChatRightQuote)
      "chat-right-quote-fill" -> Ok(ChatRightQuoteFill)
      "chat-right-text" -> Ok(ChatRightText)
      "chat-right-text-fill" -> Ok(ChatRightTextFill)
      "chat-square" -> Ok(ChatSquare)
      "chat-square-dots" -> Ok(ChatSquareDots)
      "chat-square-dots-fill" -> Ok(ChatSquareDotsFill)
      "chat-square-fill" -> Ok(ChatSquareFill)
      "chat-square-heart" -> Ok(ChatSquareHeart)
      "chat-square-heart-fill" -> Ok(ChatSquareHeartFill)
      "chat-square-quote" -> Ok(ChatSquareQuote)
      "chat-square-quote-fill" -> Ok(ChatSquareQuoteFill)
      "chat-square-text" -> Ok(ChatSquareText)
      "chat-square-text-fill" -> Ok(ChatSquareTextFill)
      "chat-text" -> Ok(ChatText)
      "chat-text-fill" -> Ok(ChatTextFill)
      "check" -> Ok(Check)
      "check-all" -> Ok(CheckAll)
      "check-circle" -> Ok(CheckCircle)
      "check-circle-fill" -> Ok(CheckCircleFill)
      "check-lg" -> Ok(CheckLg)
      "check-square" -> Ok(CheckSquare)
      "check-square-fill" -> Ok(CheckSquareFill)
      "check2" -> Ok(Check2)
      "check2-all" -> Ok(Check2All)
      "check2-circle" -> Ok(Check2Circle)
      "check2-square" -> Ok(Check2Square)
      "chevron-bar-contract" -> Ok(ChevronBarContract)
      "chevron-bar-down" -> Ok(ChevronBarDown)
      "chevron-bar-expand" -> Ok(ChevronBarExpand)
      "chevron-bar-left" -> Ok(ChevronBarLeft)
      "chevron-bar-right" -> Ok(ChevronBarRight)
      "chevron-bar-up" -> Ok(ChevronBarUp)
      "chevron-compact-down" -> Ok(ChevronCompactDown)
      "chevron-compact-left" -> Ok(ChevronCompactLeft)
      "chevron-compact-right" -> Ok(ChevronCompactRight)
      "chevron-compact-up" -> Ok(ChevronCompactUp)
      "chevron-contract" -> Ok(ChevronContract)
      "chevron-double-down" -> Ok(ChevronDoubleDown)
      "chevron-double-left" -> Ok(ChevronDoubleLeft)
      "chevron-double-right" -> Ok(ChevronDoubleRight)
      "chevron-double-up" -> Ok(ChevronDoubleUp)
      "chevron-down" -> Ok(ChevronDown)
      "chevron-expand" -> Ok(ChevronExpand)
      "chevron-left" -> Ok(ChevronLeft)
      "chevron-right" -> Ok(ChevronRight)
      "chevron-up" -> Ok(ChevronUp)
      "circle" -> Ok(Circle)
      "circle-fill" -> Ok(CircleFill)
      "circle-half" -> Ok(CircleHalf)
      "circle-square" -> Ok(CircleSquare)
      "clipboard" -> Ok(Clipboard)
      "clipboard-check" -> Ok(ClipboardCheck)
      "clipboard-check-fill" -> Ok(ClipboardCheckFill)
      "clipboard-data" -> Ok(ClipboardData)
      "clipboard-data-fill" -> Ok(ClipboardDataFill)
      "clipboard-fill" -> Ok(ClipboardFill)
      "clipboard-heart" -> Ok(ClipboardHeart)
      "clipboard-heart-fill" -> Ok(ClipboardHeartFill)
      "clipboard-minus" -> Ok(ClipboardMinus)
      "clipboard-minus-fill" -> Ok(ClipboardMinusFill)
      "clipboard-plus" -> Ok(ClipboardPlus)
      "clipboard-plus-fill" -> Ok(ClipboardPlusFill)
      "clipboard-pulse" -> Ok(ClipboardPulse)
      "clipboard-x" -> Ok(ClipboardX)
      "clipboard-x-fill" -> Ok(ClipboardXFill)
      "clipboard2" -> Ok(Clipboard2)
      "clipboard2-check" -> Ok(Clipboard2Check)
      "clipboard2-check-fill" -> Ok(Clipboard2CheckFill)
      "clipboard2-data" -> Ok(Clipboard2Data)
      "clipboard2-data-fill" -> Ok(Clipboard2DataFill)
      "clipboard2-fill" -> Ok(Clipboard2Fill)
      "clipboard2-heart" -> Ok(Clipboard2Heart)
      "clipboard2-heart-fill" -> Ok(Clipboard2HeartFill)
      "clipboard2-minus" -> Ok(Clipboard2Minus)
      "clipboard2-minus-fill" -> Ok(Clipboard2MinusFill)
      "clipboard2-plus" -> Ok(Clipboard2Plus)
      "clipboard2-plus-fill" -> Ok(Clipboard2PlusFill)
      "clipboard2-pulse" -> Ok(Clipboard2Pulse)
      "clipboard2-pulse-fill" -> Ok(Clipboard2PulseFill)
      "clipboard2-x" -> Ok(Clipboard2X)
      "clipboard2-x-fill" -> Ok(Clipboard2XFill)
      "clock" -> Ok(Clock)
      "clock-fill" -> Ok(ClockFill)
      "clock-history" -> Ok(ClockHistory)
      "cloud" -> Ok(Cloud)
      "cloud-arrow-down" -> Ok(CloudArrowDown)
      "cloud-arrow-down-fill" -> Ok(CloudArrowDownFill)
      "cloud-arrow-up" -> Ok(CloudArrowUp)
      "cloud-arrow-up-fill" -> Ok(CloudArrowUpFill)
      "cloud-check" -> Ok(CloudCheck)
      "cloud-check-fill" -> Ok(CloudCheckFill)
      "cloud-download" -> Ok(CloudDownload)
      "cloud-download-fill" -> Ok(CloudDownloadFill)
      "cloud-drizzle" -> Ok(CloudDrizzle)
      "cloud-drizzle-fill" -> Ok(CloudDrizzleFill)
      "cloud-fill" -> Ok(CloudFill)
      "cloud-fog" -> Ok(CloudFog)
      "cloud-fog-fill" -> Ok(CloudFogFill)
      "cloud-fog2" -> Ok(CloudFog2)
      "cloud-fog2-fill" -> Ok(CloudFog2Fill)
      "cloud-hail" -> Ok(CloudHail)
      "cloud-hail-fill" -> Ok(CloudHailFill)
      "cloud-haze" -> Ok(CloudHaze)
      "cloud-haze-fill" -> Ok(CloudHazeFill)
      "cloud-haze2" -> Ok(CloudHaze2)
      "cloud-haze2-fill" -> Ok(CloudHaze2Fill)
      "cloud-lightning" -> Ok(CloudLightning)
      "cloud-lightning-fill" -> Ok(CloudLightningFill)
      "cloud-lightning-rain" -> Ok(CloudLightningRain)
      "cloud-lightning-rain-fill" -> Ok(CloudLightningRainFill)
      "cloud-minus" -> Ok(CloudMinus)
      "cloud-minus-fill" -> Ok(CloudMinusFill)
      "cloud-moon" -> Ok(CloudMoon)
      "cloud-moon-fill" -> Ok(CloudMoonFill)
      "cloud-plus" -> Ok(CloudPlus)
      "cloud-plus-fill" -> Ok(CloudPlusFill)
      "cloud-rain" -> Ok(CloudRain)
      "cloud-rain-fill" -> Ok(CloudRainFill)
      "cloud-rain-heavy" -> Ok(CloudRainHeavy)
      "cloud-rain-heavy-fill" -> Ok(CloudRainHeavyFill)
      "cloud-slash" -> Ok(CloudSlash)
      "cloud-slash-fill" -> Ok(CloudSlashFill)
      "cloud-sleet" -> Ok(CloudSleet)
      "cloud-sleet-fill" -> Ok(CloudSleetFill)
      "cloud-snow" -> Ok(CloudSnow)
      "cloud-snow-fill" -> Ok(CloudSnowFill)
      "cloud-sun" -> Ok(CloudSun)
      "cloud-sun-fill" -> Ok(CloudSunFill)
      "cloud-upload" -> Ok(CloudUpload)
      "cloud-upload-fill" -> Ok(CloudUploadFill)
      "clouds" -> Ok(Clouds)
      "clouds-fill" -> Ok(CloudsFill)
      "cloudy" -> Ok(Cloudy)
      "cloudy-fill" -> Ok(CloudyFill)
      "code" -> Ok(Code)
      "code-slash" -> Ok(CodeSlash)
      "code-square" -> Ok(CodeSquare)
      "coin" -> Ok(Coin)
      "collection" -> Ok(Collection)
      "collection-fill" -> Ok(CollectionFill)
      "collection-play" -> Ok(CollectionPlay)
      "collection-play-fill" -> Ok(CollectionPlayFill)
      "columns" -> Ok(Columns)
      "columns-gap" -> Ok(ColumnsGap)
      "command" -> Ok(Command)
      "compass" -> Ok(Compass)
      "compass-fill" -> Ok(CompassFill)
      "cone" -> Ok(Cone)
      "cone-striped" -> Ok(ConeStriped)
      "controller" -> Ok(Controller)
      "cookie" -> Ok(Cookie)
      "copy" -> Ok(Copy)
      "cpu" -> Ok(Cpu)
      "cpu-fill" -> Ok(CpuFill)
      "credit-card" -> Ok(CreditCard)
      "credit-card-2-back" -> Ok(CreditCard2Back)
      "credit-card-2-back-fill" -> Ok(CreditCard2BackFill)
      "credit-card-2-front" -> Ok(CreditCard2Front)
      "credit-card-2-front-fill" -> Ok(CreditCard2FrontFill)
      "credit-card-fill" -> Ok(CreditCardFill)
      "crop" -> Ok(Crop)
      "crosshair" -> Ok(Crosshair)
      "crosshair2" -> Ok(Crosshair2)
      "cup" -> Ok(Cup)
      "cup-fill" -> Ok(CupFill)
      "cup-hot" -> Ok(CupHot)
      "cup-hot-fill" -> Ok(CupHotFill)
      "cup-straw" -> Ok(CupStraw)
      "currency-bitcoin" -> Ok(CurrencyBitcoin)
      "currency-dollar" -> Ok(CurrencyDollar)
      "currency-euro" -> Ok(CurrencyEuro)
      "currency-exchange" -> Ok(CurrencyExchange)
      "currency-pound" -> Ok(CurrencyPound)
      "currency-rupee" -> Ok(CurrencyRupee)
      "currency-yen" -> Ok(CurrencyYen)
      "cursor" -> Ok(Cursor)
      "cursor-fill" -> Ok(CursorFill)
      "cursor-text" -> Ok(CursorText)
      "dash" -> Ok(Dash)
      "dash-circle" -> Ok(DashCircle)
      "dash-circle-dotted" -> Ok(DashCircleDotted)
      "dash-circle-fill" -> Ok(DashCircleFill)
      "dash-lg" -> Ok(DashLg)
      "dash-square" -> Ok(DashSquare)
      "dash-square-dotted" -> Ok(DashSquareDotted)
      "dash-square-fill" -> Ok(DashSquareFill)
      "database" -> Ok(Database)
      "database-add" -> Ok(DatabaseAdd)
      "database-check" -> Ok(DatabaseCheck)
      "database-dash" -> Ok(DatabaseDash)
      "database-down" -> Ok(DatabaseDown)
      "database-exclamation" -> Ok(DatabaseExclamation)
      "database-fill" -> Ok(DatabaseFill)
      "database-fill-add" -> Ok(DatabaseFillAdd)
      "database-fill-check" -> Ok(DatabaseFillCheck)
      "database-fill-dash" -> Ok(DatabaseFillDash)
      "database-fill-down" -> Ok(DatabaseFillDown)
      "database-fill-exclamation" -> Ok(DatabaseFillExclamation)
      "database-fill-gear" -> Ok(DatabaseFillGear)
      "database-fill-lock" -> Ok(DatabaseFillLock)
      "database-fill-slash" -> Ok(DatabaseFillSlash)
      "database-fill-up" -> Ok(DatabaseFillUp)
      "database-fill-x" -> Ok(DatabaseFillX)
      "database-gear" -> Ok(DatabaseGear)
      "database-lock" -> Ok(DatabaseLock)
      "database-slash" -> Ok(DatabaseSlash)
      "database-up" -> Ok(DatabaseUp)
      "database-x" -> Ok(DatabaseX)
      "device-hdd" -> Ok(DeviceHdd)
      "device-hdd-fill" -> Ok(DeviceHddFill)
      "device-ssd" -> Ok(DeviceSsd)
      "device-ssd-fill" -> Ok(DeviceSsdFill)
      "diagram-2" -> Ok(Diagram2)
      "diagram-2-fill" -> Ok(Diagram2Fill)
      "diagram-3" -> Ok(Diagram3)
      "diagram-3-fill" -> Ok(Diagram3Fill)
      "diamond" -> Ok(Diamond)
      "diamond-fill" -> Ok(DiamondFill)
      "diamond-half" -> Ok(DiamondHalf)
      "dice-1" -> Ok(Dice1)
      "dice-1-fill" -> Ok(Dice1Fill)
      "dice-2" -> Ok(Dice2)
      "dice-2-fill" -> Ok(Dice2Fill)
      "dice-3" -> Ok(Dice3)
      "dice-3-fill" -> Ok(Dice3Fill)
      "dice-4" -> Ok(Dice4)
      "dice-4-fill" -> Ok(Dice4Fill)
      "dice-5" -> Ok(Dice5)
      "dice-5-fill" -> Ok(Dice5Fill)
      "dice-6" -> Ok(Dice6)
      "dice-6-fill" -> Ok(Dice6Fill)
      "disc" -> Ok(Disc)
      "disc-fill" -> Ok(DiscFill)
      "discord" -> Ok(Discord)
      "display" -> Ok(Display)
      "display-fill" -> Ok(DisplayFill)
      "displayport" -> Ok(Displayport)
      "displayport-fill" -> Ok(DisplayportFill)
      "distribute-horizontal" -> Ok(DistributeHorizontal)
      "distribute-vertical" -> Ok(DistributeVertical)
      "door-closed" -> Ok(DoorClosed)
      "door-closed-fill" -> Ok(DoorClosedFill)
      "door-open" -> Ok(DoorOpen)
      "door-open-fill" -> Ok(DoorOpenFill)
      "dot" -> Ok(Dot)
      "download" -> Ok(Download)
      "dpad" -> Ok(Dpad)
      "dpad-fill" -> Ok(DpadFill)
      "dribbble" -> Ok(Dribbble)
      "dropbox" -> Ok(Dropbox)
      "droplet" -> Ok(Droplet)
      "droplet-fill" -> Ok(DropletFill)
      "droplet-half" -> Ok(DropletHalf)
      "duffle" -> Ok(Duffle)
      "duffle-fill" -> Ok(DuffleFill)
      "ear" -> Ok(Ear)
      "ear-fill" -> Ok(EarFill)
      "earbuds" -> Ok(Earbuds)
      "easel" -> Ok(Easel)
      "easel-fill" -> Ok(EaselFill)
      "easel2" -> Ok(Easel2)
      "easel2-fill" -> Ok(Easel2Fill)
      "easel3" -> Ok(Easel3)
      "easel3-fill" -> Ok(Easel3Fill)
      "egg" -> Ok(Egg)
      "egg-fill" -> Ok(EggFill)
      "egg-fried" -> Ok(EggFried)
      "eject" -> Ok(Eject)
      "eject-fill" -> Ok(EjectFill)
      "emoji-angry" -> Ok(EmojiAngry)
      "emoji-angry-fill" -> Ok(EmojiAngryFill)
      "emoji-astonished" -> Ok(EmojiAstonished)
      "emoji-astonished-fill" -> Ok(EmojiAstonishedFill)
      "emoji-dizzy" -> Ok(EmojiDizzy)
      "emoji-dizzy-fill" -> Ok(EmojiDizzyFill)
      "emoji-expressionless" -> Ok(EmojiExpressionless)
      "emoji-expressionless-fill" -> Ok(EmojiExpressionlessFill)
      "emoji-frown" -> Ok(EmojiFrown)
      "emoji-frown-fill" -> Ok(EmojiFrownFill)
      "emoji-grimace" -> Ok(EmojiGrimace)
      "emoji-grimace-fill" -> Ok(EmojiGrimaceFill)
      "emoji-grin" -> Ok(EmojiGrin)
      "emoji-grin-fill" -> Ok(EmojiGrinFill)
      "emoji-heart-eyes" -> Ok(EmojiHeartEyes)
      "emoji-heart-eyes-fill" -> Ok(EmojiHeartEyesFill)
      "emoji-kiss" -> Ok(EmojiKiss)
      "emoji-kiss-fill" -> Ok(EmojiKissFill)
      "emoji-laughing" -> Ok(EmojiLaughing)
      "emoji-laughing-fill" -> Ok(EmojiLaughingFill)
      "emoji-neutral" -> Ok(EmojiNeutral)
      "emoji-neutral-fill" -> Ok(EmojiNeutralFill)
      "emoji-smile" -> Ok(EmojiSmile)
      "emoji-smile-fill" -> Ok(EmojiSmileFill)
      "emoji-smile-upside-down" -> Ok(EmojiSmileUpsideDown)
      "emoji-smile-upside-down-fill" -> Ok(EmojiSmileUpsideDownFill)
      "emoji-sunglasses" -> Ok(EmojiSunglasses)
      "emoji-sunglasses-fill" -> Ok(EmojiSunglassesFill)
      "emoji-surprise" -> Ok(EmojiSurprise)
      "emoji-surprise-fill" -> Ok(EmojiSurpriseFill)
      "emoji-tear" -> Ok(EmojiTear)
      "emoji-tear-fill" -> Ok(EmojiTearFill)
      "emoji-wink" -> Ok(EmojiWink)
      "emoji-wink-fill" -> Ok(EmojiWinkFill)
      "envelope" -> Ok(Envelope)
      "envelope-arrow-down" -> Ok(EnvelopeArrowDown)
      "envelope-arrow-down-fill" -> Ok(EnvelopeArrowDownFill)
      "envelope-arrow-up" -> Ok(EnvelopeArrowUp)
      "envelope-arrow-up-fill" -> Ok(EnvelopeArrowUpFill)
      "envelope-at" -> Ok(EnvelopeAt)
      "envelope-at-fill" -> Ok(EnvelopeAtFill)
      "envelope-check" -> Ok(EnvelopeCheck)
      "envelope-check-fill" -> Ok(EnvelopeCheckFill)
      "envelope-dash" -> Ok(EnvelopeDash)
      "envelope-dash-fill" -> Ok(EnvelopeDashFill)
      "envelope-exclamation" -> Ok(EnvelopeExclamation)
      "envelope-exclamation-fill" -> Ok(EnvelopeExclamationFill)
      "envelope-fill" -> Ok(EnvelopeFill)
      "envelope-heart" -> Ok(EnvelopeHeart)
      "envelope-heart-fill" -> Ok(EnvelopeHeartFill)
      "envelope-open" -> Ok(EnvelopeOpen)
      "envelope-open-fill" -> Ok(EnvelopeOpenFill)
      "envelope-open-heart" -> Ok(EnvelopeOpenHeart)
      "envelope-open-heart-fill" -> Ok(EnvelopeOpenHeartFill)
      "envelope-paper" -> Ok(EnvelopePaper)
      "envelope-paper-fill" -> Ok(EnvelopePaperFill)
      "envelope-paper-heart" -> Ok(EnvelopePaperHeart)
      "envelope-paper-heart-fill" -> Ok(EnvelopePaperHeartFill)
      "envelope-plus" -> Ok(EnvelopePlus)
      "envelope-plus-fill" -> Ok(EnvelopePlusFill)
      "envelope-slash" -> Ok(EnvelopeSlash)
      "envelope-slash-fill" -> Ok(EnvelopeSlashFill)
      "envelope-x" -> Ok(EnvelopeX)
      "envelope-x-fill" -> Ok(EnvelopeXFill)
      "eraser" -> Ok(Eraser)
      "eraser-fill" -> Ok(EraserFill)
      "escape" -> Ok(Escape)
      "ethernet" -> Ok(Ethernet)
      "ev-front" -> Ok(EvFront)
      "ev-front-fill" -> Ok(EvFrontFill)
      "ev-station" -> Ok(EvStation)
      "ev-station-fill" -> Ok(EvStationFill)
      "exclamation" -> Ok(Exclamation)
      "exclamation-circle" -> Ok(ExclamationCircle)
      "exclamation-circle-fill" -> Ok(ExclamationCircleFill)
      "exclamation-diamond" -> Ok(ExclamationDiamond)
      "exclamation-diamond-fill" -> Ok(ExclamationDiamondFill)
      "exclamation-lg" -> Ok(ExclamationLg)
      "exclamation-octagon" -> Ok(ExclamationOctagon)
      "exclamation-octagon-fill" -> Ok(ExclamationOctagonFill)
      "exclamation-square" -> Ok(ExclamationSquare)
      "exclamation-square-fill" -> Ok(ExclamationSquareFill)
      "exclamation-triangle" -> Ok(ExclamationTriangle)
      "exclamation-triangle-fill" -> Ok(ExclamationTriangleFill)
      "exclude" -> Ok(Exclude)
      "explicit" -> Ok(Explicit)
      "explicit-fill" -> Ok(ExplicitFill)
      "exposure" -> Ok(Exposure)
      "eye" -> Ok(Eye)
      "eye-fill" -> Ok(EyeFill)
      "eye-slash" -> Ok(EyeSlash)
      "eye-slash-fill" -> Ok(EyeSlashFill)
      "eyedropper" -> Ok(Eyedropper)
      "eyeglasses" -> Ok(Eyeglasses)
      "facebook" -> Ok(Facebook)
      "fan" -> Ok(Fan)
      "fast-forward" -> Ok(FastForward)
      "fast-forward-btn" -> Ok(FastForwardBtn)
      "fast-forward-btn-fill" -> Ok(FastForwardBtnFill)
      "fast-forward-circle" -> Ok(FastForwardCircle)
      "fast-forward-circle-fill" -> Ok(FastForwardCircleFill)
      "fast-forward-fill" -> Ok(FastForwardFill)
      "feather" -> Ok(Feather)
      "feather2" -> Ok(Feather2)
      "file" -> Ok(File)
      "file-arrow-down" -> Ok(FileArrowDown)
      "file-arrow-down-fill" -> Ok(FileArrowDownFill)
      "file-arrow-up" -> Ok(FileArrowUp)
      "file-arrow-up-fill" -> Ok(FileArrowUpFill)
      "file-bar-graph" -> Ok(FileBarGraph)
      "file-bar-graph-fill" -> Ok(FileBarGraphFill)
      "file-binary" -> Ok(FileBinary)
      "file-binary-fill" -> Ok(FileBinaryFill)
      "file-break" -> Ok(FileBreak)
      "file-break-fill" -> Ok(FileBreakFill)
      "file-check" -> Ok(FileCheck)
      "file-check-fill" -> Ok(FileCheckFill)
      "file-code" -> Ok(FileCode)
      "file-code-fill" -> Ok(FileCodeFill)
      "file-diff" -> Ok(FileDiff)
      "file-diff-fill" -> Ok(FileDiffFill)
      "file-earmark" -> Ok(FileEarmark)
      "file-earmark-arrow-down" -> Ok(FileEarmarkArrowDown)
      "file-earmark-arrow-down-fill" -> Ok(FileEarmarkArrowDownFill)
      "file-earmark-arrow-up" -> Ok(FileEarmarkArrowUp)
      "file-earmark-arrow-up-fill" -> Ok(FileEarmarkArrowUpFill)
      "file-earmark-bar-graph" -> Ok(FileEarmarkBarGraph)
      "file-earmark-bar-graph-fill" -> Ok(FileEarmarkBarGraphFill)
      "file-earmark-binary" -> Ok(FileEarmarkBinary)
      "file-earmark-binary-fill" -> Ok(FileEarmarkBinaryFill)
      "file-earmark-break" -> Ok(FileEarmarkBreak)
      "file-earmark-break-fill" -> Ok(FileEarmarkBreakFill)
      "file-earmark-check" -> Ok(FileEarmarkCheck)
      "file-earmark-check-fill" -> Ok(FileEarmarkCheckFill)
      "file-earmark-code" -> Ok(FileEarmarkCode)
      "file-earmark-code-fill" -> Ok(FileEarmarkCodeFill)
      "file-earmark-diff" -> Ok(FileEarmarkDiff)
      "file-earmark-diff-fill" -> Ok(FileEarmarkDiffFill)
      "file-earmark-easel" -> Ok(FileEarmarkEasel)
      "file-earmark-easel-fill" -> Ok(FileEarmarkEaselFill)
      "file-earmark-excel" -> Ok(FileEarmarkExcel)
      "file-earmark-excel-fill" -> Ok(FileEarmarkExcelFill)
      "file-earmark-fill" -> Ok(FileEarmarkFill)
      "file-earmark-font" -> Ok(FileEarmarkFont)
      "file-earmark-font-fill" -> Ok(FileEarmarkFontFill)
      "file-earmark-image" -> Ok(FileEarmarkImage)
      "file-earmark-image-fill" -> Ok(FileEarmarkImageFill)
      "file-earmark-lock" -> Ok(FileEarmarkLock)
      "file-earmark-lock-fill" -> Ok(FileEarmarkLockFill)
      "file-earmark-lock2" -> Ok(FileEarmarkLock2)
      "file-earmark-lock2-fill" -> Ok(FileEarmarkLock2Fill)
      "file-earmark-medical" -> Ok(FileEarmarkMedical)
      "file-earmark-medical-fill" -> Ok(FileEarmarkMedicalFill)
      "file-earmark-minus" -> Ok(FileEarmarkMinus)
      "file-earmark-minus-fill" -> Ok(FileEarmarkMinusFill)
      "file-earmark-music" -> Ok(FileEarmarkMusic)
      "file-earmark-music-fill" -> Ok(FileEarmarkMusicFill)
      "file-earmark-pdf" -> Ok(FileEarmarkPdf)
      "file-earmark-pdf-fill" -> Ok(FileEarmarkPdfFill)
      "file-earmark-person" -> Ok(FileEarmarkPerson)
      "file-earmark-person-fill" -> Ok(FileEarmarkPersonFill)
      "file-earmark-play" -> Ok(FileEarmarkPlay)
      "file-earmark-play-fill" -> Ok(FileEarmarkPlayFill)
      "file-earmark-plus" -> Ok(FileEarmarkPlus)
      "file-earmark-plus-fill" -> Ok(FileEarmarkPlusFill)
      "file-earmark-post" -> Ok(FileEarmarkPost)
      "file-earmark-post-fill" -> Ok(FileEarmarkPostFill)
      "file-earmark-ppt" -> Ok(FileEarmarkPpt)
      "file-earmark-ppt-fill" -> Ok(FileEarmarkPptFill)
      "file-earmark-richtext" -> Ok(FileEarmarkRichtext)
      "file-earmark-richtext-fill" -> Ok(FileEarmarkRichtextFill)
      "file-earmark-ruled" -> Ok(FileEarmarkRuled)
      "file-earmark-ruled-fill" -> Ok(FileEarmarkRuledFill)
      "file-earmark-slides" -> Ok(FileEarmarkSlides)
      "file-earmark-slides-fill" -> Ok(FileEarmarkSlidesFill)
      "file-earmark-spreadsheet" -> Ok(FileEarmarkSpreadsheet)
      "file-earmark-spreadsheet-fill" -> Ok(FileEarmarkSpreadsheetFill)
      "file-earmark-text" -> Ok(FileEarmarkText)
      "file-earmark-text-fill" -> Ok(FileEarmarkTextFill)
      "file-earmark-word" -> Ok(FileEarmarkWord)
      "file-earmark-word-fill" -> Ok(FileEarmarkWordFill)
      "file-earmark-x" -> Ok(FileEarmarkX)
      "file-earmark-x-fill" -> Ok(FileEarmarkXFill)
      "file-earmark-zip" -> Ok(FileEarmarkZip)
      "file-earmark-zip-fill" -> Ok(FileEarmarkZipFill)
      "file-easel" -> Ok(FileEasel)
      "file-easel-fill" -> Ok(FileEaselFill)
      "file-excel" -> Ok(FileExcel)
      "file-excel-fill" -> Ok(FileExcelFill)
      "file-fill" -> Ok(FileFill)
      "file-font" -> Ok(FileFont)
      "file-font-fill" -> Ok(FileFontFill)
      "file-image" -> Ok(FileImage)
      "file-image-fill" -> Ok(FileImageFill)
      "file-lock" -> Ok(FileLock)
      "file-lock-fill" -> Ok(FileLockFill)
      "file-lock2" -> Ok(FileLock2)
      "file-lock2-fill" -> Ok(FileLock2Fill)
      "file-medical" -> Ok(FileMedical)
      "file-medical-fill" -> Ok(FileMedicalFill)
      "file-minus" -> Ok(FileMinus)
      "file-minus-fill" -> Ok(FileMinusFill)
      "file-music" -> Ok(FileMusic)
      "file-music-fill" -> Ok(FileMusicFill)
      "file-pdf" -> Ok(FilePdf)
      "file-pdf-fill" -> Ok(FilePdfFill)
      "file-person" -> Ok(FilePerson)
      "file-person-fill" -> Ok(FilePersonFill)
      "file-play" -> Ok(FilePlay)
      "file-play-fill" -> Ok(FilePlayFill)
      "file-plus" -> Ok(FilePlus)
      "file-plus-fill" -> Ok(FilePlusFill)
      "file-post" -> Ok(FilePost)
      "file-post-fill" -> Ok(FilePostFill)
      "file-ppt" -> Ok(FilePpt)
      "file-ppt-fill" -> Ok(FilePptFill)
      "file-richtext" -> Ok(FileRichtext)
      "file-richtext-fill" -> Ok(FileRichtextFill)
      "file-ruled" -> Ok(FileRuled)
      "file-ruled-fill" -> Ok(FileRuledFill)
      "file-slides" -> Ok(FileSlides)
      "file-slides-fill" -> Ok(FileSlidesFill)
      "file-spreadsheet" -> Ok(FileSpreadsheet)
      "file-spreadsheet-fill" -> Ok(FileSpreadsheetFill)
      "file-text" -> Ok(FileText)
      "file-text-fill" -> Ok(FileTextFill)
      "file-word" -> Ok(FileWord)
      "file-word-fill" -> Ok(FileWordFill)
      "file-x" -> Ok(FileX)
      "file-x-fill" -> Ok(FileXFill)
      "file-zip" -> Ok(FileZip)
      "file-zip-fill" -> Ok(FileZipFill)
      "files" -> Ok(Files)
      "files-alt" -> Ok(FilesAlt)
      "filetype-aac" -> Ok(FiletypeAac)
      "filetype-ai" -> Ok(FiletypeAi)
      "filetype-bmp" -> Ok(FiletypeBmp)
      "filetype-cs" -> Ok(FiletypeCs)
      "filetype-css" -> Ok(FiletypeCss)
      "filetype-csv" -> Ok(FiletypeCsv)
      "filetype-doc" -> Ok(FiletypeDoc)
      "filetype-docx" -> Ok(FiletypeDocx)
      "filetype-exe" -> Ok(FiletypeExe)
      "filetype-gif" -> Ok(FiletypeGif)
      "filetype-heic" -> Ok(FiletypeHeic)
      "filetype-html" -> Ok(FiletypeHtml)
      "filetype-java" -> Ok(FiletypeJava)
      "filetype-jpg" -> Ok(FiletypeJpg)
      "filetype-js" -> Ok(FiletypeJs)
      "filetype-json" -> Ok(FiletypeJson)
      "filetype-jsx" -> Ok(FiletypeJsx)
      "filetype-key" -> Ok(FiletypeKey)
      "filetype-m4p" -> Ok(FiletypeM4p)
      "filetype-md" -> Ok(FiletypeMd)
      "filetype-mdx" -> Ok(FiletypeMdx)
      "filetype-mov" -> Ok(FiletypeMov)
      "filetype-mp3" -> Ok(FiletypeMp3)
      "filetype-mp4" -> Ok(FiletypeMp4)
      "filetype-otf" -> Ok(FiletypeOtf)
      "filetype-pdf" -> Ok(FiletypePdf)
      "filetype-php" -> Ok(FiletypePhp)
      "filetype-png" -> Ok(FiletypePng)
      "filetype-ppt" -> Ok(FiletypePpt)
      "filetype-pptx" -> Ok(FiletypePptx)
      "filetype-psd" -> Ok(FiletypePsd)
      "filetype-py" -> Ok(FiletypePy)
      "filetype-raw" -> Ok(FiletypeRaw)
      "filetype-rb" -> Ok(FiletypeRb)
      "filetype-sass" -> Ok(FiletypeSass)
      "filetype-scss" -> Ok(FiletypeScss)
      "filetype-sh" -> Ok(FiletypeSh)
      "filetype-sql" -> Ok(FiletypeSql)
      "filetype-svg" -> Ok(FiletypeSvg)
      "filetype-tiff" -> Ok(FiletypeTiff)
      "filetype-tsx" -> Ok(FiletypeTsx)
      "filetype-ttf" -> Ok(FiletypeTtf)
      "filetype-txt" -> Ok(FiletypeTxt)
      "filetype-wav" -> Ok(FiletypeWav)
      "filetype-woff" -> Ok(FiletypeWoff)
      "filetype-xls" -> Ok(FiletypeXls)
      "filetype-xlsx" -> Ok(FiletypeXlsx)
      "filetype-xml" -> Ok(FiletypeXml)
      "filetype-yml" -> Ok(FiletypeYml)
      "film" -> Ok(Film)
      "filter" -> Ok(Filter)
      "filter-circle" -> Ok(FilterCircle)
      "filter-circle-fill" -> Ok(FilterCircleFill)
      "filter-left" -> Ok(FilterLeft)
      "filter-right" -> Ok(FilterRight)
      "filter-square" -> Ok(FilterSquare)
      "filter-square-fill" -> Ok(FilterSquareFill)
      "fingerprint" -> Ok(Fingerprint)
      "fire" -> Ok(Fire)
      "flag" -> Ok(Flag)
      "flag-fill" -> Ok(FlagFill)
      "floppy" -> Ok(Floppy)
      "floppy-fill" -> Ok(FloppyFill)
      "floppy2" -> Ok(Floppy2)
      "floppy2-fill" -> Ok(Floppy2Fill)
      "flower1" -> Ok(Flower1)
      "flower2" -> Ok(Flower2)
      "flower3" -> Ok(Flower3)
      "folder" -> Ok(Folder)
      "folder-check" -> Ok(FolderCheck)
      "folder-fill" -> Ok(FolderFill)
      "folder-minus" -> Ok(FolderMinus)
      "folder-plus" -> Ok(FolderPlus)
      "folder-symlink" -> Ok(FolderSymlink)
      "folder-symlink-fill" -> Ok(FolderSymlinkFill)
      "folder-x" -> Ok(FolderX)
      "folder2" -> Ok(Folder2)
      "folder2-open" -> Ok(Folder2Open)
      "fonts" -> Ok(Fonts)
      "forward" -> Ok(Forward)
      "forward-fill" -> Ok(ForwardFill)
      "front" -> Ok(Front)
      "fuel-pump" -> Ok(FuelPump)
      "fuel-pump-diesel" -> Ok(FuelPumpDiesel)
      "fuel-pump-diesel-fill" -> Ok(FuelPumpDieselFill)
      "fuel-pump-fill" -> Ok(FuelPumpFill)
      "fullscreen" -> Ok(Fullscreen)
      "fullscreen-exit" -> Ok(FullscreenExit)
      "funnel" -> Ok(Funnel)
      "funnel-fill" -> Ok(FunnelFill)
      "gear" -> Ok(Gear)
      "gear-fill" -> Ok(GearFill)
      "gear-wide" -> Ok(GearWide)
      "gear-wide-connected" -> Ok(GearWideConnected)
      "gem" -> Ok(Gem)
      "gender-ambiguous" -> Ok(GenderAmbiguous)
      "gender-female" -> Ok(GenderFemale)
      "gender-male" -> Ok(GenderMale)
      "gender-neuter" -> Ok(GenderNeuter)
      "gender-trans" -> Ok(GenderTrans)
      "geo" -> Ok(Geo)
      "geo-alt" -> Ok(GeoAlt)
      "geo-alt-fill" -> Ok(GeoAltFill)
      "geo-fill" -> Ok(GeoFill)
      "gift" -> Ok(Gift)
      "gift-fill" -> Ok(GiftFill)
      "git" -> Ok(Git)
      "github" -> Ok(Github)
      "gitlab" -> Ok(Gitlab)
      "globe" -> Ok(Globe)
      "globe-americas" -> Ok(GlobeAmericas)
      "globe-asia-australia" -> Ok(GlobeAsiaAustralia)
      "globe-central-south-asia" -> Ok(GlobeCentralSouthAsia)
      "globe-europe-africa" -> Ok(GlobeEuropeAfrica)
      "globe2" -> Ok(Globe2)
      "google" -> Ok(Google)
      "google-play" -> Ok(GooglePlay)
      "gpu-card" -> Ok(GpuCard)
      "graph-down" -> Ok(GraphDown)
      "graph-down-arrow" -> Ok(GraphDownArrow)
      "graph-up" -> Ok(GraphUp)
      "graph-up-arrow" -> Ok(GraphUpArrow)
      "grid" -> Ok(Grid)
      "grid-1x2" -> Ok(Grid1x2)
      "grid-1x2-fill" -> Ok(Grid1x2Fill)
      "grid-3x2" -> Ok(Grid3x2)
      "grid-3x2-gap" -> Ok(Grid3x2Gap)
      "grid-3x2-gap-fill" -> Ok(Grid3x2GapFill)
      "grid-3x3" -> Ok(Grid3x3)
      "grid-3x3-gap" -> Ok(Grid3x3Gap)
      "grid-3x3-gap-fill" -> Ok(Grid3x3GapFill)
      "grid-fill" -> Ok(GridFill)
      "grip-horizontal" -> Ok(GripHorizontal)
      "grip-vertical" -> Ok(GripVertical)
      "h-circle" -> Ok(HCircle)
      "h-circle-fill" -> Ok(HCircleFill)
      "h-square" -> Ok(HSquare)
      "h-square-fill" -> Ok(HSquareFill)
      "hammer" -> Ok(Hammer)
      "hand-index" -> Ok(HandIndex)
      "hand-index-fill" -> Ok(HandIndexFill)
      "hand-index-thumb" -> Ok(HandIndexThumb)
      "hand-index-thumb-fill" -> Ok(HandIndexThumbFill)
      "hand-thumbs-down" -> Ok(HandThumbsDown)
      "hand-thumbs-down-fill" -> Ok(HandThumbsDownFill)
      "hand-thumbs-up" -> Ok(HandThumbsUp)
      "hand-thumbs-up-fill" -> Ok(HandThumbsUpFill)
      "handbag" -> Ok(Handbag)
      "handbag-fill" -> Ok(HandbagFill)
      "hash" -> Ok(Hash)
      "hdd" -> Ok(Hdd)
      "hdd-fill" -> Ok(HddFill)
      "hdd-network" -> Ok(HddNetwork)
      "hdd-network-fill" -> Ok(HddNetworkFill)
      "hdd-rack" -> Ok(HddRack)
      "hdd-rack-fill" -> Ok(HddRackFill)
      "hdd-stack" -> Ok(HddStack)
      "hdd-stack-fill" -> Ok(HddStackFill)
      "hdmi" -> Ok(Hdmi)
      "hdmi-fill" -> Ok(HdmiFill)
      "headphones" -> Ok(Headphones)
      "headset" -> Ok(Headset)
      "headset-vr" -> Ok(HeadsetVr)
      "heart" -> Ok(Heart)
      "heart-arrow" -> Ok(HeartArrow)
      "heart-fill" -> Ok(HeartFill)
      "heart-half" -> Ok(HeartHalf)
      "heart-pulse" -> Ok(HeartPulse)
      "heart-pulse-fill" -> Ok(HeartPulseFill)
      "heartbreak" -> Ok(Heartbreak)
      "heartbreak-fill" -> Ok(HeartbreakFill)
      "hearts" -> Ok(Hearts)
      "heptagon" -> Ok(Heptagon)
      "heptagon-fill" -> Ok(HeptagonFill)
      "heptagon-half" -> Ok(HeptagonHalf)
      "hexagon" -> Ok(Hexagon)
      "hexagon-fill" -> Ok(HexagonFill)
      "hexagon-half" -> Ok(HexagonHalf)
      "highlighter" -> Ok(Highlighter)
      "highlights" -> Ok(Highlights)
      "hospital" -> Ok(Hospital)
      "hospital-fill" -> Ok(HospitalFill)
      "hourglass" -> Ok(Hourglass)
      "hourglass-bottom" -> Ok(HourglassBottom)
      "hourglass-split" -> Ok(HourglassSplit)
      "hourglass-top" -> Ok(HourglassTop)
      "house" -> Ok(House)
      "house-add" -> Ok(HouseAdd)
      "house-add-fill" -> Ok(HouseAddFill)
      "house-check" -> Ok(HouseCheck)
      "house-check-fill" -> Ok(HouseCheckFill)
      "house-dash" -> Ok(HouseDash)
      "house-dash-fill" -> Ok(HouseDashFill)
      "house-door" -> Ok(HouseDoor)
      "house-door-fill" -> Ok(HouseDoorFill)
      "house-down" -> Ok(HouseDown)
      "house-down-fill" -> Ok(HouseDownFill)
      "house-exclamation" -> Ok(HouseExclamation)
      "house-exclamation-fill" -> Ok(HouseExclamationFill)
      "house-fill" -> Ok(HouseFill)
      "house-gear" -> Ok(HouseGear)
      "house-gear-fill" -> Ok(HouseGearFill)
      "house-heart" -> Ok(HouseHeart)
      "house-heart-fill" -> Ok(HouseHeartFill)
      "house-lock" -> Ok(HouseLock)
      "house-lock-fill" -> Ok(HouseLockFill)
      "house-slash" -> Ok(HouseSlash)
      "house-slash-fill" -> Ok(HouseSlashFill)
      "house-up" -> Ok(HouseUp)
      "house-up-fill" -> Ok(HouseUpFill)
      "house-x" -> Ok(HouseX)
      "house-x-fill" -> Ok(HouseXFill)
      "houses" -> Ok(Houses)
      "houses-fill" -> Ok(HousesFill)
      "hr" -> Ok(Hr)
      "hurricane" -> Ok(Hurricane)
      "hypnotize" -> Ok(Hypnotize)
      "image" -> Ok(Image)
      "image-alt" -> Ok(ImageAlt)
      "image-fill" -> Ok(ImageFill)
      "images" -> Ok(Images)
      "inbox" -> Ok(Inbox)
      "inbox-fill" -> Ok(InboxFill)
      "inboxes" -> Ok(Inboxes)
      "inboxes-fill" -> Ok(InboxesFill)
      "incognito" -> Ok(Incognito)
      "indent" -> Ok(Indent)
      "infinity" -> Ok(Infinity)
      "info" -> Ok(Info)
      "info-circle" -> Ok(InfoCircle)
      "info-circle-fill" -> Ok(InfoCircleFill)
      "info-lg" -> Ok(InfoLg)
      "info-square" -> Ok(InfoSquare)
      "info-square-fill" -> Ok(InfoSquareFill)
      "input-cursor" -> Ok(InputCursor)
      "input-cursor-text" -> Ok(InputCursorText)
      "instagram" -> Ok(Instagram)
      "intersect" -> Ok(Intersect)
      "journal" -> Ok(Journal)
      "journal-album" -> Ok(JournalAlbum)
      "journal-arrow-down" -> Ok(JournalArrowDown)
      "journal-arrow-up" -> Ok(JournalArrowUp)
      "journal-bookmark" -> Ok(JournalBookmark)
      "journal-bookmark-fill" -> Ok(JournalBookmarkFill)
      "journal-check" -> Ok(JournalCheck)
      "journal-code" -> Ok(JournalCode)
      "journal-medical" -> Ok(JournalMedical)
      "journal-minus" -> Ok(JournalMinus)
      "journal-plus" -> Ok(JournalPlus)
      "journal-richtext" -> Ok(JournalRichtext)
      "journal-text" -> Ok(JournalText)
      "journal-x" -> Ok(JournalX)
      "journals" -> Ok(Journals)
      "joystick" -> Ok(Joystick)
      "justify" -> Ok(Justify)
      "justify-left" -> Ok(JustifyLeft)
      "justify-right" -> Ok(JustifyRight)
      "kanban" -> Ok(Kanban)
      "kanban-fill" -> Ok(KanbanFill)
      "key" -> Ok(Key)
      "key-fill" -> Ok(KeyFill)
      "keyboard" -> Ok(Keyboard)
      "keyboard-fill" -> Ok(KeyboardFill)
      "ladder" -> Ok(Ladder)
      "lamp" -> Ok(Lamp)
      "lamp-fill" -> Ok(LampFill)
      "laptop" -> Ok(Laptop)
      "laptop-fill" -> Ok(LaptopFill)
      "layer-backward" -> Ok(LayerBackward)
      "layer-forward" -> Ok(LayerForward)
      "layers" -> Ok(Layers)
      "layers-fill" -> Ok(LayersFill)
      "layers-half" -> Ok(LayersHalf)
      "layout-sidebar" -> Ok(LayoutSidebar)
      "layout-sidebar-inset" -> Ok(LayoutSidebarInset)
      "layout-sidebar-inset-reverse" -> Ok(LayoutSidebarInsetReverse)
      "layout-sidebar-reverse" -> Ok(LayoutSidebarReverse)
      "layout-split" -> Ok(LayoutSplit)
      "layout-text-sidebar" -> Ok(LayoutTextSidebar)
      "layout-text-sidebar-reverse" -> Ok(LayoutTextSidebarReverse)
      "layout-text-window" -> Ok(LayoutTextWindow)
      "layout-text-window-reverse" -> Ok(LayoutTextWindowReverse)
      "layout-three-columns" -> Ok(LayoutThreeColumns)
      "layout-wtf" -> Ok(LayoutWtf)
      "life-preserver" -> Ok(LifePreserver)
      "lightbulb" -> Ok(Lightbulb)
      "lightbulb-fill" -> Ok(LightbulbFill)
      "lightbulb-off" -> Ok(LightbulbOff)
      "lightbulb-off-fill" -> Ok(LightbulbOffFill)
      "lightning" -> Ok(Lightning)
      "lightning-charge" -> Ok(LightningCharge)
      "lightning-charge-fill" -> Ok(LightningChargeFill)
      "lightning-fill" -> Ok(LightningFill)
      "line" -> Ok(Line)
      "link" -> Ok(Link)
      "link-45deg" -> Ok(Link45deg)
      "linkedin" -> Ok(Linkedin)
      "list" -> Ok(List)
      "list-check" -> Ok(ListCheck)
      "list-columns" -> Ok(ListColumns)
      "list-columns-reverse" -> Ok(ListColumnsReverse)
      "list-nested" -> Ok(ListNested)
      "list-ol" -> Ok(ListOl)
      "list-stars" -> Ok(ListStars)
      "list-task" -> Ok(ListTask)
      "list-ul" -> Ok(ListUl)
      "lock" -> Ok(Lock)
      "lock-fill" -> Ok(LockFill)
      "luggage" -> Ok(Luggage)
      "luggage-fill" -> Ok(LuggageFill)
      "lungs" -> Ok(Lungs)
      "lungs-fill" -> Ok(LungsFill)
      "magic" -> Ok(Magic)
      "magnet" -> Ok(Magnet)
      "magnet-fill" -> Ok(MagnetFill)
      "mailbox" -> Ok(Mailbox)
      "mailbox-flag" -> Ok(MailboxFlag)
      "mailbox2" -> Ok(Mailbox2)
      "mailbox2-flag" -> Ok(Mailbox2Flag)
      "map" -> Ok(Map)
      "map-fill" -> Ok(MapFill)
      "markdown" -> Ok(Markdown)
      "markdown-fill" -> Ok(MarkdownFill)
      "marker-tip" -> Ok(MarkerTip)
      "mask" -> Ok(Mask)
      "mastodon" -> Ok(Mastodon)
      "medium" -> Ok(Medium)
      "megaphone" -> Ok(Megaphone)
      "megaphone-fill" -> Ok(MegaphoneFill)
      "memory" -> Ok(Memory)
      "menu-app" -> Ok(MenuApp)
      "menu-app-fill" -> Ok(MenuAppFill)
      "menu-button" -> Ok(MenuButton)
      "menu-button-fill" -> Ok(MenuButtonFill)
      "menu-button-wide" -> Ok(MenuButtonWide)
      "menu-button-wide-fill" -> Ok(MenuButtonWideFill)
      "menu-down" -> Ok(MenuDown)
      "menu-up" -> Ok(MenuUp)
      "messenger" -> Ok(Messenger)
      "meta" -> Ok(Meta)
      "mic" -> Ok(Mic)
      "mic-fill" -> Ok(MicFill)
      "mic-mute" -> Ok(MicMute)
      "mic-mute-fill" -> Ok(MicMuteFill)
      "microsoft" -> Ok(Microsoft)
      "microsoft-teams" -> Ok(MicrosoftTeams)
      "minecart" -> Ok(Minecart)
      "minecart-loaded" -> Ok(MinecartLoaded)
      "modem" -> Ok(Modem)
      "modem-fill" -> Ok(ModemFill)
      "moisture" -> Ok(Moisture)
      "moon" -> Ok(Moon)
      "moon-fill" -> Ok(MoonFill)
      "moon-stars" -> Ok(MoonStars)
      "moon-stars-fill" -> Ok(MoonStarsFill)
      "mortarboard" -> Ok(Mortarboard)
      "mortarboard-fill" -> Ok(MortarboardFill)
      "motherboard" -> Ok(Motherboard)
      "motherboard-fill" -> Ok(MotherboardFill)
      "mouse" -> Ok(Mouse)
      "mouse-fill" -> Ok(MouseFill)
      "mouse2" -> Ok(Mouse2)
      "mouse2-fill" -> Ok(Mouse2Fill)
      "mouse3" -> Ok(Mouse3)
      "mouse3-fill" -> Ok(Mouse3Fill)
      "music-note" -> Ok(MusicNote)
      "music-note-beamed" -> Ok(MusicNoteBeamed)
      "music-note-list" -> Ok(MusicNoteList)
      "music-player" -> Ok(MusicPlayer)
      "music-player-fill" -> Ok(MusicPlayerFill)
      "newspaper" -> Ok(Newspaper)
      "nintendo-switch" -> Ok(NintendoSwitch)
      "node-minus" -> Ok(NodeMinus)
      "node-minus-fill" -> Ok(NodeMinusFill)
      "node-plus" -> Ok(NodePlus)
      "node-plus-fill" -> Ok(NodePlusFill)
      "noise-reduction" -> Ok(NoiseReduction)
      "nut" -> Ok(Nut)
      "nut-fill" -> Ok(NutFill)
      "nvidia" -> Ok(Nvidia)
      "nvme" -> Ok(Nvme)
      "nvme-fill" -> Ok(NvmeFill)
      "octagon" -> Ok(Octagon)
      "octagon-fill" -> Ok(OctagonFill)
      "octagon-half" -> Ok(OctagonHalf)
      "opencollective" -> Ok(Opencollective)
      "optical-audio" -> Ok(OpticalAudio)
      "optical-audio-fill" -> Ok(OpticalAudioFill)
      "option" -> Ok(Option)
      "outlet" -> Ok(Outlet)
      "p-circle" -> Ok(PCircle)
      "p-circle-fill" -> Ok(PCircleFill)
      "p-square" -> Ok(PSquare)
      "p-square-fill" -> Ok(PSquareFill)
      "paint-bucket" -> Ok(PaintBucket)
      "palette" -> Ok(Palette)
      "palette-fill" -> Ok(PaletteFill)
      "palette2" -> Ok(Palette2)
      "paperclip" -> Ok(Paperclip)
      "paragraph" -> Ok(Paragraph)
      "pass" -> Ok(Pass)
      "pass-fill" -> Ok(PassFill)
      "passport" -> Ok(Passport)
      "passport-fill" -> Ok(PassportFill)
      "patch-check" -> Ok(PatchCheck)
      "patch-check-fill" -> Ok(PatchCheckFill)
      "patch-exclamation" -> Ok(PatchExclamation)
      "patch-exclamation-fill" -> Ok(PatchExclamationFill)
      "patch-minus" -> Ok(PatchMinus)
      "patch-minus-fill" -> Ok(PatchMinusFill)
      "patch-plus" -> Ok(PatchPlus)
      "patch-plus-fill" -> Ok(PatchPlusFill)
      "patch-question" -> Ok(PatchQuestion)
      "patch-question-fill" -> Ok(PatchQuestionFill)
      "pause" -> Ok(Pause)
      "pause-btn" -> Ok(PauseBtn)
      "pause-btn-fill" -> Ok(PauseBtnFill)
      "pause-circle" -> Ok(PauseCircle)
      "pause-circle-fill" -> Ok(PauseCircleFill)
      "pause-fill" -> Ok(PauseFill)
      "paypal" -> Ok(Paypal)
      "pc" -> Ok(Pc)
      "pc-display" -> Ok(PcDisplay)
      "pc-display-horizontal" -> Ok(PcDisplayHorizontal)
      "pc-horizontal" -> Ok(PcHorizontal)
      "pci-card" -> Ok(PciCard)
      "pci-card-network" -> Ok(PciCardNetwork)
      "pci-card-sound" -> Ok(PciCardSound)
      "peace" -> Ok(Peace)
      "peace-fill" -> Ok(PeaceFill)
      "pen" -> Ok(Pen)
      "pen-fill" -> Ok(PenFill)
      "pencil" -> Ok(Pencil)
      "pencil-fill" -> Ok(PencilFill)
      "pencil-square" -> Ok(PencilSquare)
      "pentagon" -> Ok(Pentagon)
      "pentagon-fill" -> Ok(PentagonFill)
      "pentagon-half" -> Ok(PentagonHalf)
      "people" -> Ok(People)
      "people-fill" -> Ok(PeopleFill)
      "percent" -> Ok(Percent)
      "person" -> Ok(Person)
      "person-add" -> Ok(PersonAdd)
      "person-arms-up" -> Ok(PersonArmsUp)
      "person-badge" -> Ok(PersonBadge)
      "person-badge-fill" -> Ok(PersonBadgeFill)
      "person-bounding-box" -> Ok(PersonBoundingBox)
      "person-check" -> Ok(PersonCheck)
      "person-check-fill" -> Ok(PersonCheckFill)
      "person-circle" -> Ok(PersonCircle)
      "person-dash" -> Ok(PersonDash)
      "person-dash-fill" -> Ok(PersonDashFill)
      "person-down" -> Ok(PersonDown)
      "person-exclamation" -> Ok(PersonExclamation)
      "person-fill" -> Ok(PersonFill)
      "person-fill-add" -> Ok(PersonFillAdd)
      "person-fill-check" -> Ok(PersonFillCheck)
      "person-fill-dash" -> Ok(PersonFillDash)
      "person-fill-down" -> Ok(PersonFillDown)
      "person-fill-exclamation" -> Ok(PersonFillExclamation)
      "person-fill-gear" -> Ok(PersonFillGear)
      "person-fill-lock" -> Ok(PersonFillLock)
      "person-fill-slash" -> Ok(PersonFillSlash)
      "person-fill-up" -> Ok(PersonFillUp)
      "person-fill-x" -> Ok(PersonFillX)
      "person-gear" -> Ok(PersonGear)
      "person-heart" -> Ok(PersonHeart)
      "person-hearts" -> Ok(PersonHearts)
      "person-lines-fill" -> Ok(PersonLinesFill)
      "person-lock" -> Ok(PersonLock)
      "person-plus" -> Ok(PersonPlus)
      "person-plus-fill" -> Ok(PersonPlusFill)
      "person-raised-hand" -> Ok(PersonRaisedHand)
      "person-rolodex" -> Ok(PersonRolodex)
      "person-slash" -> Ok(PersonSlash)
      "person-square" -> Ok(PersonSquare)
      "person-standing" -> Ok(PersonStanding)
      "person-standing-dress" -> Ok(PersonStandingDress)
      "person-up" -> Ok(PersonUp)
      "person-vcard" -> Ok(PersonVcard)
      "person-vcard-fill" -> Ok(PersonVcardFill)
      "person-video" -> Ok(PersonVideo)
      "person-video2" -> Ok(PersonVideo2)
      "person-video3" -> Ok(PersonVideo3)
      "person-walking" -> Ok(PersonWalking)
      "person-wheelchair" -> Ok(PersonWheelchair)
      "person-workspace" -> Ok(PersonWorkspace)
      "person-x" -> Ok(PersonX)
      "person-x-fill" -> Ok(PersonXFill)
      "phone" -> Ok(Phone)
      "phone-fill" -> Ok(PhoneFill)
      "phone-flip" -> Ok(PhoneFlip)
      "phone-landscape" -> Ok(PhoneLandscape)
      "phone-landscape-fill" -> Ok(PhoneLandscapeFill)
      "phone-vibrate" -> Ok(PhoneVibrate)
      "phone-vibrate-fill" -> Ok(PhoneVibrateFill)
      "pie-chart" -> Ok(PieChart)
      "pie-chart-fill" -> Ok(PieChartFill)
      "piggy-bank" -> Ok(PiggyBank)
      "piggy-bank-fill" -> Ok(PiggyBankFill)
      "pin" -> Ok(Pin)
      "pin-angle" -> Ok(PinAngle)
      "pin-angle-fill" -> Ok(PinAngleFill)
      "pin-fill" -> Ok(PinFill)
      "pin-map" -> Ok(PinMap)
      "pin-map-fill" -> Ok(PinMapFill)
      "pinterest" -> Ok(Pinterest)
      "pip" -> Ok(Pip)
      "pip-fill" -> Ok(PipFill)
      "play" -> Ok(Play)
      "play-btn" -> Ok(PlayBtn)
      "play-btn-fill" -> Ok(PlayBtnFill)
      "play-circle" -> Ok(PlayCircle)
      "play-circle-fill" -> Ok(PlayCircleFill)
      "play-fill" -> Ok(PlayFill)
      "playstation" -> Ok(Playstation)
      "plug" -> Ok(Plug)
      "plug-fill" -> Ok(PlugFill)
      "plugin" -> Ok(Plugin)
      "plus" -> Ok(Plus)
      "plus-circle" -> Ok(PlusCircle)
      "plus-circle-dotted" -> Ok(PlusCircleDotted)
      "plus-circle-fill" -> Ok(PlusCircleFill)
      "plus-lg" -> Ok(PlusLg)
      "plus-slash-minus" -> Ok(PlusSlashMinus)
      "plus-square" -> Ok(PlusSquare)
      "plus-square-dotted" -> Ok(PlusSquareDotted)
      "plus-square-fill" -> Ok(PlusSquareFill)
      "postage" -> Ok(Postage)
      "postage-fill" -> Ok(PostageFill)
      "postage-heart" -> Ok(PostageHeart)
      "postage-heart-fill" -> Ok(PostageHeartFill)
      "postcard" -> Ok(Postcard)
      "postcard-fill" -> Ok(PostcardFill)
      "postcard-heart" -> Ok(PostcardHeart)
      "postcard-heart-fill" -> Ok(PostcardHeartFill)
      "power" -> Ok(Power)
      "prescription" -> Ok(Prescription)
      "prescription2" -> Ok(Prescription2)
      "printer" -> Ok(Printer)
      "printer-fill" -> Ok(PrinterFill)
      "projector" -> Ok(Projector)
      "projector-fill" -> Ok(ProjectorFill)
      "puzzle" -> Ok(Puzzle)
      "puzzle-fill" -> Ok(PuzzleFill)
      "qr-code" -> Ok(QrCode)
      "qr-code-scan" -> Ok(QrCodeScan)
      "question" -> Ok(Question)
      "question-circle" -> Ok(QuestionCircle)
      "question-circle-fill" -> Ok(QuestionCircleFill)
      "question-diamond" -> Ok(QuestionDiamond)
      "question-diamond-fill" -> Ok(QuestionDiamondFill)
      "question-lg" -> Ok(QuestionLg)
      "question-octagon" -> Ok(QuestionOctagon)
      "question-octagon-fill" -> Ok(QuestionOctagonFill)
      "question-square" -> Ok(QuestionSquare)
      "question-square-fill" -> Ok(QuestionSquareFill)
      "quora" -> Ok(Quora)
      "quote" -> Ok(Quote)
      "r-circle" -> Ok(RCircle)
      "r-circle-fill" -> Ok(RCircleFill)
      "r-square" -> Ok(RSquare)
      "r-square-fill" -> Ok(RSquareFill)
      "radar" -> Ok(Radar)
      "radioactive" -> Ok(Radioactive)
      "rainbow" -> Ok(Rainbow)
      "receipt" -> Ok(Receipt)
      "receipt-cutoff" -> Ok(ReceiptCutoff)
      "reception-0" -> Ok(Reception0)
      "reception-1" -> Ok(Reception1)
      "reception-2" -> Ok(Reception2)
      "reception-3" -> Ok(Reception3)
      "reception-4" -> Ok(Reception4)
      "record" -> Ok(Record)
      "record-btn" -> Ok(RecordBtn)
      "record-btn-fill" -> Ok(RecordBtnFill)
      "record-circle" -> Ok(RecordCircle)
      "record-circle-fill" -> Ok(RecordCircleFill)
      "record-fill" -> Ok(RecordFill)
      "record2" -> Ok(Record2)
      "record2-fill" -> Ok(Record2Fill)
      "recycle" -> Ok(Recycle)
      "reddit" -> Ok(Reddit)
      "regex" -> Ok(Regex)
      "repeat" -> Ok(Repeat)
      "repeat-1" -> Ok(Repeat1)
      "reply" -> Ok(Reply)
      "reply-all" -> Ok(ReplyAll)
      "reply-all-fill" -> Ok(ReplyAllFill)
      "reply-fill" -> Ok(ReplyFill)
      "rewind" -> Ok(Rewind)
      "rewind-btn" -> Ok(RewindBtn)
      "rewind-btn-fill" -> Ok(RewindBtnFill)
      "rewind-circle" -> Ok(RewindCircle)
      "rewind-circle-fill" -> Ok(RewindCircleFill)
      "rewind-fill" -> Ok(RewindFill)
      "robot" -> Ok(Robot)
      "rocket" -> Ok(Rocket)
      "rocket-fill" -> Ok(RocketFill)
      "rocket-takeoff" -> Ok(RocketTakeoff)
      "rocket-takeoff-fill" -> Ok(RocketTakeoffFill)
      "router" -> Ok(Router)
      "router-fill" -> Ok(RouterFill)
      "rss" -> Ok(Rss)
      "rss-fill" -> Ok(RssFill)
      "rulers" -> Ok(Rulers)
      "safe" -> Ok(Safe)
      "safe-fill" -> Ok(SafeFill)
      "safe2" -> Ok(Safe2)
      "safe2-fill" -> Ok(Safe2Fill)
      "save" -> Ok(Save)
      "save-fill" -> Ok(SaveFill)
      "save2" -> Ok(Save2)
      "save2-fill" -> Ok(Save2Fill)
      "scissors" -> Ok(Scissors)
      "scooter" -> Ok(Scooter)
      "screwdriver" -> Ok(Screwdriver)
      "sd-card" -> Ok(SdCard)
      "sd-card-fill" -> Ok(SdCardFill)
      "search" -> Ok(Search)
      "search-heart" -> Ok(SearchHeart)
      "search-heart-fill" -> Ok(SearchHeartFill)
      "segmented-nav" -> Ok(SegmentedNav)
      "send" -> Ok(Send)
      "send-arrow-down" -> Ok(SendArrowDown)
      "send-arrow-down-fill" -> Ok(SendArrowDownFill)
      "send-arrow-up" -> Ok(SendArrowUp)
      "send-arrow-up-fill" -> Ok(SendArrowUpFill)
      "send-check" -> Ok(SendCheck)
      "send-check-fill" -> Ok(SendCheckFill)
      "send-dash" -> Ok(SendDash)
      "send-dash-fill" -> Ok(SendDashFill)
      "send-exclamation" -> Ok(SendExclamation)
      "send-exclamation-fill" -> Ok(SendExclamationFill)
      "send-fill" -> Ok(SendFill)
      "send-plus" -> Ok(SendPlus)
      "send-plus-fill" -> Ok(SendPlusFill)
      "send-slash" -> Ok(SendSlash)
      "send-slash-fill" -> Ok(SendSlashFill)
      "send-x" -> Ok(SendX)
      "send-x-fill" -> Ok(SendXFill)
      "server" -> Ok(Server)
      "shadows" -> Ok(Shadows)
      "share" -> Ok(Share)
      "share-fill" -> Ok(ShareFill)
      "shield" -> Ok(Shield)
      "shield-check" -> Ok(ShieldCheck)
      "shield-exclamation" -> Ok(ShieldExclamation)
      "shield-fill" -> Ok(ShieldFill)
      "shield-fill-check" -> Ok(ShieldFillCheck)
      "shield-fill-exclamation" -> Ok(ShieldFillExclamation)
      "shield-fill-minus" -> Ok(ShieldFillMinus)
      "shield-fill-plus" -> Ok(ShieldFillPlus)
      "shield-fill-x" -> Ok(ShieldFillX)
      "shield-lock" -> Ok(ShieldLock)
      "shield-lock-fill" -> Ok(ShieldLockFill)
      "shield-minus" -> Ok(ShieldMinus)
      "shield-plus" -> Ok(ShieldPlus)
      "shield-shaded" -> Ok(ShieldShaded)
      "shield-slash" -> Ok(ShieldSlash)
      "shield-slash-fill" -> Ok(ShieldSlashFill)
      "shield-x" -> Ok(ShieldX)
      "shift" -> Ok(Shift)
      "shift-fill" -> Ok(ShiftFill)
      "shop" -> Ok(Shop)
      "shop-window" -> Ok(ShopWindow)
      "shuffle" -> Ok(Shuffle)
      "sign-dead-end" -> Ok(SignDeadEnd)
      "sign-dead-end-fill" -> Ok(SignDeadEndFill)
      "sign-do-not-enter" -> Ok(SignDoNotEnter)
      "sign-do-not-enter-fill" -> Ok(SignDoNotEnterFill)
      "sign-intersection" -> Ok(SignIntersection)
      "sign-intersection-fill" -> Ok(SignIntersectionFill)
      "sign-intersection-side" -> Ok(SignIntersectionSide)
      "sign-intersection-side-fill" -> Ok(SignIntersectionSideFill)
      "sign-intersection-t" -> Ok(SignIntersectionT)
      "sign-intersection-t-fill" -> Ok(SignIntersectionTFill)
      "sign-intersection-y" -> Ok(SignIntersectionY)
      "sign-intersection-y-fill" -> Ok(SignIntersectionYFill)
      "sign-merge-left" -> Ok(SignMergeLeft)
      "sign-merge-left-fill" -> Ok(SignMergeLeftFill)
      "sign-merge-right" -> Ok(SignMergeRight)
      "sign-merge-right-fill" -> Ok(SignMergeRightFill)
      "sign-no-left-turn" -> Ok(SignNoLeftTurn)
      "sign-no-left-turn-fill" -> Ok(SignNoLeftTurnFill)
      "sign-no-parking" -> Ok(SignNoParking)
      "sign-no-parking-fill" -> Ok(SignNoParkingFill)
      "sign-no-right-turn" -> Ok(SignNoRightTurn)
      "sign-no-right-turn-fill" -> Ok(SignNoRightTurnFill)
      "sign-railroad" -> Ok(SignRailroad)
      "sign-railroad-fill" -> Ok(SignRailroadFill)
      "sign-stop" -> Ok(SignStop)
      "sign-stop-fill" -> Ok(SignStopFill)
      "sign-stop-lights" -> Ok(SignStopLights)
      "sign-stop-lights-fill" -> Ok(SignStopLightsFill)
      "sign-turn-left" -> Ok(SignTurnLeft)
      "sign-turn-left-fill" -> Ok(SignTurnLeftFill)
      "sign-turn-right" -> Ok(SignTurnRight)
      "sign-turn-right-fill" -> Ok(SignTurnRightFill)
      "sign-turn-slight-left" -> Ok(SignTurnSlightLeft)
      "sign-turn-slight-left-fill" -> Ok(SignTurnSlightLeftFill)
      "sign-turn-slight-right" -> Ok(SignTurnSlightRight)
      "sign-turn-slight-right-fill" -> Ok(SignTurnSlightRightFill)
      "sign-yield" -> Ok(SignYield)
      "sign-yield-fill" -> Ok(SignYieldFill)
      "signal" -> Ok(Signal)
      "signpost" -> Ok(Signpost)
      "signpost-2" -> Ok(Signpost2)
      "signpost-2-fill" -> Ok(Signpost2Fill)
      "signpost-fill" -> Ok(SignpostFill)
      "signpost-split" -> Ok(SignpostSplit)
      "signpost-split-fill" -> Ok(SignpostSplitFill)
      "sim" -> Ok(Sim)
      "sim-fill" -> Ok(SimFill)
      "sim-slash" -> Ok(SimSlash)
      "sim-slash-fill" -> Ok(SimSlashFill)
      "sina-weibo" -> Ok(SinaWeibo)
      "skip-backward" -> Ok(SkipBackward)
      "skip-backward-btn" -> Ok(SkipBackwardBtn)
      "skip-backward-btn-fill" -> Ok(SkipBackwardBtnFill)
      "skip-backward-circle" -> Ok(SkipBackwardCircle)
      "skip-backward-circle-fill" -> Ok(SkipBackwardCircleFill)
      "skip-backward-fill" -> Ok(SkipBackwardFill)
      "skip-end" -> Ok(SkipEnd)
      "skip-end-btn" -> Ok(SkipEndBtn)
      "skip-end-btn-fill" -> Ok(SkipEndBtnFill)
      "skip-end-circle" -> Ok(SkipEndCircle)
      "skip-end-circle-fill" -> Ok(SkipEndCircleFill)
      "skip-end-fill" -> Ok(SkipEndFill)
      "skip-forward" -> Ok(SkipForward)
      "skip-forward-btn" -> Ok(SkipForwardBtn)
      "skip-forward-btn-fill" -> Ok(SkipForwardBtnFill)
      "skip-forward-circle" -> Ok(SkipForwardCircle)
      "skip-forward-circle-fill" -> Ok(SkipForwardCircleFill)
      "skip-forward-fill" -> Ok(SkipForwardFill)
      "skip-start" -> Ok(SkipStart)
      "skip-start-btn" -> Ok(SkipStartBtn)
      "skip-start-btn-fill" -> Ok(SkipStartBtnFill)
      "skip-start-circle" -> Ok(SkipStartCircle)
      "skip-start-circle-fill" -> Ok(SkipStartCircleFill)
      "skip-start-fill" -> Ok(SkipStartFill)
      "skype" -> Ok(Skype)
      "slack" -> Ok(Slack)
      "slash" -> Ok(Slash)
      "slash-circle" -> Ok(SlashCircle)
      "slash-circle-fill" -> Ok(SlashCircleFill)
      "slash-lg" -> Ok(SlashLg)
      "slash-square" -> Ok(SlashSquare)
      "slash-square-fill" -> Ok(SlashSquareFill)
      "sliders" -> Ok(Sliders)
      "sliders2" -> Ok(Sliders2)
      "sliders2-vertical" -> Ok(Sliders2Vertical)
      "smartwatch" -> Ok(Smartwatch)
      "snapchat" -> Ok(Snapchat)
      "snow" -> Ok(Snow)
      "snow2" -> Ok(Snow2)
      "snow3" -> Ok(Snow3)
      "sort-alpha-down" -> Ok(SortAlphaDown)
      "sort-alpha-down-alt" -> Ok(SortAlphaDownAlt)
      "sort-alpha-up" -> Ok(SortAlphaUp)
      "sort-alpha-up-alt" -> Ok(SortAlphaUpAlt)
      "sort-down" -> Ok(SortDown)
      "sort-down-alt" -> Ok(SortDownAlt)
      "sort-numeric-down" -> Ok(SortNumericDown)
      "sort-numeric-down-alt" -> Ok(SortNumericDownAlt)
      "sort-numeric-up" -> Ok(SortNumericUp)
      "sort-numeric-up-alt" -> Ok(SortNumericUpAlt)
      "sort-up" -> Ok(SortUp)
      "sort-up-alt" -> Ok(SortUpAlt)
      "soundwave" -> Ok(Soundwave)
      "sourceforge" -> Ok(Sourceforge)
      "speaker" -> Ok(Speaker)
      "speaker-fill" -> Ok(SpeakerFill)
      "speedometer" -> Ok(Speedometer)
      "speedometer2" -> Ok(Speedometer2)
      "spellcheck" -> Ok(Spellcheck)
      "spotify" -> Ok(Spotify)
      "square" -> Ok(Square)
      "square-fill" -> Ok(SquareFill)
      "square-half" -> Ok(SquareHalf)
      "stack" -> Ok(Stack)
      "stack-overflow" -> Ok(StackOverflow)
      "star" -> Ok(Star)
      "star-fill" -> Ok(StarFill)
      "star-half" -> Ok(StarHalf)
      "stars" -> Ok(Stars)
      "steam" -> Ok(Steam)
      "stickies" -> Ok(Stickies)
      "stickies-fill" -> Ok(StickiesFill)
      "sticky" -> Ok(Sticky)
      "sticky-fill" -> Ok(StickyFill)
      "stop" -> Ok(Stop)
      "stop-btn" -> Ok(StopBtn)
      "stop-btn-fill" -> Ok(StopBtnFill)
      "stop-circle" -> Ok(StopCircle)
      "stop-circle-fill" -> Ok(StopCircleFill)
      "stop-fill" -> Ok(StopFill)
      "stoplights" -> Ok(Stoplights)
      "stoplights-fill" -> Ok(StoplightsFill)
      "stopwatch" -> Ok(Stopwatch)
      "stopwatch-fill" -> Ok(StopwatchFill)
      "strava" -> Ok(Strava)
      "stripe" -> Ok(Stripe)
      "subscript" -> Ok(Subscript)
      "substack" -> Ok(Substack)
      "subtract" -> Ok(Subtract)
      "suit-club" -> Ok(SuitClub)
      "suit-club-fill" -> Ok(SuitClubFill)
      "suit-diamond" -> Ok(SuitDiamond)
      "suit-diamond-fill" -> Ok(SuitDiamondFill)
      "suit-heart" -> Ok(SuitHeart)
      "suit-heart-fill" -> Ok(SuitHeartFill)
      "suit-spade" -> Ok(SuitSpade)
      "suit-spade-fill" -> Ok(SuitSpadeFill)
      "suitcase" -> Ok(Suitcase)
      "suitcase-fill" -> Ok(SuitcaseFill)
      "suitcase-lg" -> Ok(SuitcaseLg)
      "suitcase-lg-fill" -> Ok(SuitcaseLgFill)
      "suitcase2" -> Ok(Suitcase2)
      "suitcase2-fill" -> Ok(Suitcase2Fill)
      "sun" -> Ok(Sun)
      "sun-fill" -> Ok(SunFill)
      "sunglasses" -> Ok(Sunglasses)
      "sunrise" -> Ok(Sunrise)
      "sunrise-fill" -> Ok(SunriseFill)
      "sunset" -> Ok(Sunset)
      "sunset-fill" -> Ok(SunsetFill)
      "superscript" -> Ok(Superscript)
      "symmetry-horizontal" -> Ok(SymmetryHorizontal)
      "symmetry-vertical" -> Ok(SymmetryVertical)
      "table" -> Ok(Table)
      "tablet" -> Ok(Tablet)
      "tablet-fill" -> Ok(TabletFill)
      "tablet-landscape" -> Ok(TabletLandscape)
      "tablet-landscape-fill" -> Ok(TabletLandscapeFill)
      "tag" -> Ok(Tag)
      "tag-fill" -> Ok(TagFill)
      "tags" -> Ok(Tags)
      "tags-fill" -> Ok(TagsFill)
      "taxi-front" -> Ok(TaxiFront)
      "taxi-front-fill" -> Ok(TaxiFrontFill)
      "telegram" -> Ok(Telegram)
      "telephone" -> Ok(Telephone)
      "telephone-fill" -> Ok(TelephoneFill)
      "telephone-forward" -> Ok(TelephoneForward)
      "telephone-forward-fill" -> Ok(TelephoneForwardFill)
      "telephone-inbound" -> Ok(TelephoneInbound)
      "telephone-inbound-fill" -> Ok(TelephoneInboundFill)
      "telephone-minus" -> Ok(TelephoneMinus)
      "telephone-minus-fill" -> Ok(TelephoneMinusFill)
      "telephone-outbound" -> Ok(TelephoneOutbound)
      "telephone-outbound-fill" -> Ok(TelephoneOutboundFill)
      "telephone-plus" -> Ok(TelephonePlus)
      "telephone-plus-fill" -> Ok(TelephonePlusFill)
      "telephone-x" -> Ok(TelephoneX)
      "telephone-x-fill" -> Ok(TelephoneXFill)
      "tencent-qq" -> Ok(TencentQq)
      "terminal" -> Ok(Terminal)
      "terminal-dash" -> Ok(TerminalDash)
      "terminal-fill" -> Ok(TerminalFill)
      "terminal-plus" -> Ok(TerminalPlus)
      "terminal-split" -> Ok(TerminalSplit)
      "terminal-x" -> Ok(TerminalX)
      "text-center" -> Ok(TextCenter)
      "text-indent-left" -> Ok(TextIndentLeft)
      "text-indent-right" -> Ok(TextIndentRight)
      "text-left" -> Ok(TextLeft)
      "text-paragraph" -> Ok(TextParagraph)
      "text-right" -> Ok(TextRight)
      "text-wrap" -> Ok(TextWrap)
      "textarea" -> Ok(Textarea)
      "textarea-resize" -> Ok(TextareaResize)
      "textarea-t" -> Ok(TextareaT)
      "thermometer" -> Ok(Thermometer)
      "thermometer-half" -> Ok(ThermometerHalf)
      "thermometer-high" -> Ok(ThermometerHigh)
      "thermometer-low" -> Ok(ThermometerLow)
      "thermometer-snow" -> Ok(ThermometerSnow)
      "thermometer-sun" -> Ok(ThermometerSun)
      "threads" -> Ok(Threads)
      "threads-fill" -> Ok(ThreadsFill)
      "three-dots" -> Ok(ThreeDots)
      "three-dots-vertical" -> Ok(ThreeDotsVertical)
      "thunderbolt" -> Ok(Thunderbolt)
      "thunderbolt-fill" -> Ok(ThunderboltFill)
      "ticket" -> Ok(Ticket)
      "ticket-detailed" -> Ok(TicketDetailed)
      "ticket-detailed-fill" -> Ok(TicketDetailedFill)
      "ticket-fill" -> Ok(TicketFill)
      "ticket-perforated" -> Ok(TicketPerforated)
      "ticket-perforated-fill" -> Ok(TicketPerforatedFill)
      "tiktok" -> Ok(Tiktok)
      "toggle-off" -> Ok(ToggleOff)
      "toggle-on" -> Ok(ToggleOn)
      "toggle2-off" -> Ok(Toggle2Off)
      "toggle2-on" -> Ok(Toggle2On)
      "toggles" -> Ok(Toggles)
      "toggles2" -> Ok(Toggles2)
      "tools" -> Ok(Tools)
      "tornado" -> Ok(Tornado)
      "train-freight-front" -> Ok(TrainFreightFront)
      "train-freight-front-fill" -> Ok(TrainFreightFrontFill)
      "train-front" -> Ok(TrainFront)
      "train-front-fill" -> Ok(TrainFrontFill)
      "train-lightrail-front" -> Ok(TrainLightrailFront)
      "train-lightrail-front-fill" -> Ok(TrainLightrailFrontFill)
      "translate" -> Ok(Translate)
      "transparency" -> Ok(Transparency)
      "trash" -> Ok(Trash)
      "trash-fill" -> Ok(TrashFill)
      "trash2" -> Ok(Trash2)
      "trash2-fill" -> Ok(Trash2Fill)
      "trash3" -> Ok(Trash3)
      "trash3-fill" -> Ok(Trash3Fill)
      "tree" -> Ok(Tree)
      "tree-fill" -> Ok(TreeFill)
      "trello" -> Ok(Trello)
      "triangle" -> Ok(Triangle)
      "triangle-fill" -> Ok(TriangleFill)
      "triangle-half" -> Ok(TriangleHalf)
      "trophy" -> Ok(Trophy)
      "trophy-fill" -> Ok(TrophyFill)
      "tropical-storm" -> Ok(TropicalStorm)
      "truck" -> Ok(Truck)
      "truck-flatbed" -> Ok(TruckFlatbed)
      "truck-front" -> Ok(TruckFront)
      "truck-front-fill" -> Ok(TruckFrontFill)
      "tsunami" -> Ok(Tsunami)
      "tv" -> Ok(Tv)
      "tv-fill" -> Ok(TvFill)
      "twitch" -> Ok(Twitch)
      "twitter" -> Ok(Twitter)
      "twitter-x" -> Ok(TwitterX)
      "type" -> Ok(Type)
      "type-bold" -> Ok(TypeBold)
      "type-h1" -> Ok(TypeH1)
      "type-h2" -> Ok(TypeH2)
      "type-h3" -> Ok(TypeH3)
      "type-h4" -> Ok(TypeH4)
      "type-h5" -> Ok(TypeH5)
      "type-h6" -> Ok(TypeH6)
      "type-italic" -> Ok(TypeItalic)
      "type-strikethrough" -> Ok(TypeStrikethrough)
      "type-underline" -> Ok(TypeUnderline)
      "ubuntu" -> Ok(Ubuntu)
      "ui-checks" -> Ok(UiChecks)
      "ui-checks-grid" -> Ok(UiChecksGrid)
      "ui-radios" -> Ok(UiRadios)
      "ui-radios-grid" -> Ok(UiRadiosGrid)
      "umbrella" -> Ok(Umbrella)
      "umbrella-fill" -> Ok(UmbrellaFill)
      "unindent" -> Ok(Unindent)
      "union" -> Ok(Union)
      "unity" -> Ok(Unity)
      "universal-access" -> Ok(UniversalAccess)
      "universal-access-circle" -> Ok(UniversalAccessCircle)
      "unlock" -> Ok(Unlock)
      "unlock-fill" -> Ok(UnlockFill)
      "upc" -> Ok(Upc)
      "upc-scan" -> Ok(UpcScan)
      "upload" -> Ok(Upload)
      "usb" -> Ok(Usb)
      "usb-c" -> Ok(UsbC)
      "usb-c-fill" -> Ok(UsbCFill)
      "usb-drive" -> Ok(UsbDrive)
      "usb-drive-fill" -> Ok(UsbDriveFill)
      "usb-fill" -> Ok(UsbFill)
      "usb-micro" -> Ok(UsbMicro)
      "usb-micro-fill" -> Ok(UsbMicroFill)
      "usb-mini" -> Ok(UsbMini)
      "usb-mini-fill" -> Ok(UsbMiniFill)
      "usb-plug" -> Ok(UsbPlug)
      "usb-plug-fill" -> Ok(UsbPlugFill)
      "usb-symbol" -> Ok(UsbSymbol)
      "valentine" -> Ok(Valentine)
      "valentine2" -> Ok(Valentine2)
      "vector-pen" -> Ok(VectorPen)
      "view-list" -> Ok(ViewList)
      "view-stacked" -> Ok(ViewStacked)
      "vignette" -> Ok(Vignette)
      "vimeo" -> Ok(Vimeo)
      "vinyl" -> Ok(Vinyl)
      "vinyl-fill" -> Ok(VinylFill)
      "virus" -> Ok(Virus)
      "virus2" -> Ok(Virus2)
      "voicemail" -> Ok(Voicemail)
      "volume-down" -> Ok(VolumeDown)
      "volume-down-fill" -> Ok(VolumeDownFill)
      "volume-mute" -> Ok(VolumeMute)
      "volume-mute-fill" -> Ok(VolumeMuteFill)
      "volume-off" -> Ok(VolumeOff)
      "volume-off-fill" -> Ok(VolumeOffFill)
      "volume-up" -> Ok(VolumeUp)
      "volume-up-fill" -> Ok(VolumeUpFill)
      "vr" -> Ok(Vr)
      "wallet" -> Ok(Wallet)
      "wallet-fill" -> Ok(WalletFill)
      "wallet2" -> Ok(Wallet2)
      "watch" -> Ok(Watch)
      "water" -> Ok(Water)
      "webcam" -> Ok(Webcam)
      "webcam-fill" -> Ok(WebcamFill)
      "wechat" -> Ok(Wechat)
      "whatsapp" -> Ok(Whatsapp)
      "wifi" -> Ok(Wifi)
      "wifi-1" -> Ok(Wifi1)
      "wifi-2" -> Ok(Wifi2)
      "wifi-off" -> Ok(WifiOff)
      "wikipedia" -> Ok(Wikipedia)
      "wind" -> Ok(Wind)
      "window" -> Ok(Window)
      "window-dash" -> Ok(WindowDash)
      "window-desktop" -> Ok(WindowDesktop)
      "window-dock" -> Ok(WindowDock)
      "window-fullscreen" -> Ok(WindowFullscreen)
      "window-plus" -> Ok(WindowPlus)
      "window-sidebar" -> Ok(WindowSidebar)
      "window-split" -> Ok(WindowSplit)
      "window-stack" -> Ok(WindowStack)
      "window-x" -> Ok(WindowX)
      "windows" -> Ok(Windows)
      "wordpress" -> Ok(Wordpress)
      "wrench" -> Ok(Wrench)
      "wrench-adjustable" -> Ok(WrenchAdjustable)
      "wrench-adjustable-circle" -> Ok(WrenchAdjustableCircle)
      "wrench-adjustable-circle-fill" -> Ok(WrenchAdjustableCircleFill)
      "x" -> Ok(X)
      "x-circle" -> Ok(XCircle)
      "x-circle-fill" -> Ok(XCircleFill)
      "x-diamond" -> Ok(XDiamond)
      "x-diamond-fill" -> Ok(XDiamondFill)
      "x-lg" -> Ok(XLg)
      "x-octagon" -> Ok(XOctagon)
      "x-octagon-fill" -> Ok(XOctagonFill)
      "x-square" -> Ok(XSquare)
      "x-square-fill" -> Ok(XSquareFill)
      "xbox" -> Ok(Xbox)
      "yelp" -> Ok(Yelp)
      "yin-yang" -> Ok(YinYang)
      "youtube" -> Ok(Youtube)
      "zoom-in" -> Ok(ZoomIn)
      "zoom-out" -> Ok(ZoomOut)
      _ -> Error([DecodeError("a valid icon type", value, ["icon-type"])])
    }
  })
}

pub type Icon {
  Icon(icon_type: IconType, typography: Typography)
}

pub fn icon(icon_type: IconType) -> Icon {
  Icon(icon_type: icon_type, typography: typography.new())
}

/// https://tailwindcss.com/docs/font-family
pub fn family(icon: Icon, family: FontFamily) -> Icon {
  Icon(
    ..icon,
    typography: Typography(..icon.typography, font_family: Some(family)),
  )
}

/// https://tailwindcss.com/docs/font-size
pub fn size(icon: Icon, size: FontSize) -> Icon {
  Icon(..icon, typography: Typography(..icon.typography, font_size: Some(size)))
}

/// https://tailwindcss.com/docs/font-style
pub fn italic(icon: Icon, style: FontStyle) -> Icon {
  Icon(
    ..icon,
    typography: Typography(..icon.typography, font_style: Some(style)),
  )
}

/// https://tailwindcss.com/docs/font-weight
pub fn weight(icon: Icon, weight: FontWeight) -> Icon {
  Icon(
    ..icon,
    typography: Typography(..icon.typography, font_weight: Some(weight)),
  )
}

/// https://tailwindcss.com/docs/text-decoration
pub fn decoration(icon: Icon, decoration: TextDecoration) -> Icon {
  Icon(
    ..icon,
    typography: Typography(..icon.typography, text_decoration: Some(decoration)),
  )
}

pub fn encode(icon: Icon) -> Json {
  json.object([
    #("icon-type", json.string(icon.icon_type |> stringify_item_type)),
    #("typography", typography.encode(icon.typography)),
  ])
}

pub fn decoder() -> fn(Dynamic) -> Result(Icon, List(DecodeError)) {
  dynamic.decode2(
    Icon,
    dynamic.field("icon-type", item_type_decoder),
    dynamic.field("typography", typography.decoder()),
  )
}

pub fn render(icon: Icon) -> Element(a) {
  html.i(
    [
      attribute.class("bi"),
      attribute.class("bi-" <> stringify_item_type(icon.icon_type)),
      ..typography.attributes(icon.typography)
    ],
    [],
  )
}

pub fn render_tree(icon: Icon) -> InnerNode(c, a) {
  LeafNode(element: render(icon))
}
