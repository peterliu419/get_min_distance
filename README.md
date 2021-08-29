# get_min_distance
資料前處理:

try&error:
  # 1. google sheet + google function(googlemaps_distance) + google apps script(類java script) 
    => 直接取得距離及距離最小值 
	=> google 限制每日使用 function 次數
  # 2. google sheet + google function(googlemaps_latlong)+ R [library(geosphere)] 
    => 取得經緯度並用r來取距離最小值 
    => google 限制每日使用 function 次數 + 部分經緯度轉換有異常
	=> R nested loop 運算時間過慢 (35000筆跟七個分類比對要跑6小時)
  # 3. TGOS + R [library(geosphere)] 
    => 透過TGOS (一個帳號一天一萬筆) 取得經緯度 
	=> 再透過 R 距離矩陣(distm) 求距離最小值 (35000筆跟七個分類比對只要跑13分鐘)

流程:
  # 處理成TGOS能接受的格式並處理地址缺失值
  # 取得TGOS資料再做經緯度缺失值整理
  # 跑 R 取得距離最小值 再做缺失值處理


轉經緯度方法:
  # TGOS 地理資訊圖資雲服務平台
  # Google function (googlemaps_latlong)


經緯度缺失值:  
  #1. TGOS 找不到經緯度 => 使用Google function 幫忙找經緯度
  #2. TGOS 判定出多個地點 => 多個經緯度 => 以第一個為主
  #3. 爬下來的房屋資料有多個地址 => TGOS 判定出多個經緯度 => 以第一個為主
  
  # 小數點位數不同:
  TGOS 到小數點後6位
  Google function到小數點後7位
  https://hiking.biji.co/index.php?q=review&act=info&review_id=5989
  後五位在台彎就足夠精準了 => 統一到小數點後6位
  
跑R
  # 一萬筆房屋資料跟七個類別各自比較取距離最小值 => 不到3分鐘
  # 跑完 R 有缺失值10個:
    檢查final_full_table 合併前的 get_min => 缺失值原本都有跑出來 => 從新更新上去
