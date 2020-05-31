ShowMessage "启动脚本。。。。。"


// 横屏
//x 
//|__ y
  
//以下是多点触控的例子
/////TouchDown 436,193, 1//按住屏幕上的100,100坐标不放，并设置此触点ID=1
//TouchDown 200, 200, 2//按住屏幕上的200,200坐标不放，并设置此触点ID=2
//TouchMove 300, 300, 1, 200//将ID=1的触点花200毫秒移动至300,300坐标
//////TouchMove 610,345, 1, 200//将ID=2的触点花200毫秒移动至500,500坐标
////TouchUp 1//松开弹起ID=1的触点
/////TouchUp 2//松开弹起ID=2的触点


Dim offsetX = 260
Dim offsetY = 292

Dim CloseXPoint = array(988,2010)
// 3 个特征点 array(y, x)
Dim point1 = array(876, 760)
Dim point2 = array(833,777)
Dim point3 = array(894,757)
// 第一个灯笼的特征
Dim firstDengLong = array(array(point1(0), point1(1), GetPixelColor(point1(0), point1(1))), array(point2(0), point2(1), GetPixelColor(point2(0), point2(1))), array(point3(0), point3(1), GetPixelColor(point3(0), point3(1))) )
    
Dim dengLongArr = array()

Dim i=0,count=0
// 所有灯笼的比较坐标点，12个 [[[5,3],[3,1]] , [[5,3],[3,1]]]
// 12 次循环
For i = 0 To 2
    dim j = 0
    For j = 0 To 3
        dengLongArr(count) = array()
        // 类似 dengLongArr[count][0]
        dengLongArr(count, 0) = Array(firstDengLong(0, 0) - i * offsetX, firstDengLong(0, 1) + j * offsetY)
        dengLongArr(count, 1) = Array(firstDengLong(1, 0) - i * offsetX, firstDengLong(1, 1) + j * offsetY)
        dengLongArr(count, 2) = Array(firstDengLong(2, 0) - i * offsetX, firstDengLong(2, 1) + j * offsetY)
       
        //TracePrint dengLongArr(count,0,0) & "=====" & dengLongArr(count,0,1) & "++++++" & dengLongArr(count,1,0) & "=====" & dengLongArr(count,1,1)
        //TracePrint count
        count = count + 1
    Next
Next
    
// 合并灯笼
Function heBingDengLong()
    i = 0
    j = 0
    // 第一个灯笼的特征
    Dim firstDengLong = array(array(point1(0), point1(1), GetPixelColor(point1(0), point1(1))), array(point2(0), point2(1), GetPixelColor(point2(0), point2(1))), array(point3(0), point3(1), GetPixelColor(point3(0), point3(1))) )
    Dim currDengLongColorArr = array()
    // 11 次循环
    For i = 0 To 11
    	 
        //dim str = dengLongArr(i,0,0)&"|"& dengLongArr(i,0,1) & "|" & firstDengLong(0,2) & "-101010," & dengLongArr(i,1,0)&"|"& dengLongArr(i,1,1) & "|" & firstDengLong(1,2) & "-101010," & dengLongArr(i,2,0)&"|"& dengLongArr(i,2,1) & "|" & firstDengLong(2,2) & "-101010"
        //TracePrint i + 1  & "------" & str
        //当前脚本第43行：617|224|A2E4FA-101010,608|198|D3F7FF-101010
        
        currDengLongColorArr = array( GetPixelColor(dengLongArr(i,0,0), dengLongArr(i,0,1)), GetPixelColor(dengLongArr(i,1,0), dengLongArr(i,1,1)), GetPixelColor(dengLongArr(i,2,0), dengLongArr(i,2,1)))

        For j = 1 To 11
            closeX ()
            closeComm()
        
            
             
            TracePrint "这一点"
            dim str = dengLongArr(j,0,0)&"|"& dengLongArr(j,0,1) & "|" & currDengLongColorArr(0) & "-101010," & dengLongArr(j,1,0)&"|"& dengLongArr(j,1,1) & "|" & currDengLongColorArr(1) & "-101010," & dengLongArr(j,2,0)&"|"& dengLongArr(j,2,1) & "|" & currDengLongColorArr(2) & "-101010"
	
            If Not(i = j) and CmpColorEx(str, 0.9 ) = 1 Then
                TracePrint 	 str & "找到没有" & i+1 & "->" & j+1
                // 合并灯笼 
                heBingDengLongTouch (dengLongArr(i,0,0), dengLongArr(i,0,1), dengLongArr(j,0,0), dengLongArr(j,0,1))
                //EndScript
                //Exit For
            Else
                //TracePrint 0
           
            End If
        Next 
        
    Next
        
End Function


Function hebingDengLong2()
    i = 0
    j = 0
    Dim temp
   
    // 11 次循环
    For i = 0 To 10
        closeX ()
        closeComm()
         temp = i
        For j = 0 To 10
           
           
        
            heBingDengLongTouch (dengLongArr(temp,0,0), dengLongArr(temp,0,1), dengLongArr(j,0,0), dengLongArr(j,0,1))
            temp = j
        Next 
        
    Next
End Function

// 移动指定灯笼到第一位置
Function moveToFirst(number)
    TracePrint "----------------------------" & number
    TouchDown dengLongArr(number-1,0,0),dengLongArr(number-1,0,1), 1//按住屏幕上的100,100坐标不放，并设置此触点ID=1
    TouchMove firstDengLong(0,0),firstDengLong(0,1), 1//将ID=2的触点花200毫秒移动至500,500坐标
    TouchUp 1//松开弹起ID=1的触点
    // TracePrint "移动力" 
End Function


// 拖拽合并
Function heBingDengLongTouch(x1, y1, x2, y2)
    TracePrint "----------------------------" 
    TouchDown x1,y1, 1//按住屏幕上的100,100坐标不放，并设置此触点ID=1
    TouchMove x2, y2, 1//将ID=1的触点花200毫秒移动至500,500坐标
    TouchUp 1//松开弹起ID=1的触点
 
End Function

// 关
Function closeX()
    // 免费升级的点击
    If CmpColorEx("266|1054|FFFFFF-101010,253|1165|FFFFFF-101010,242|1240|FFFFFF-101010",0.9) = 1 Then
        TracePrint "免费升级"
        Touch 226, 1054, 100
    End If
    
    If CmpColorEx(CloseXPoint(0)&"|"&CloseXPoint(1) & "|" & "818283-202020", 0.9 ) = 1 And hasShadowWindow() = True Then
             
        Touch 989, 1963, 20
    ElseIf CmpColorEx(989& "|" & 1963& "|" & "1E25AE-202020", 0.9) = 1 And hasShadowWindow() = True  Then
    	
        Touch 989, 1963, 20
        //TracePrint 0
    ElseIf CmpColorEx("991|2029|828284-202020", 0.9) = 1 Then
        Touch 991, 2029, 20
        
    ElseIf CmpColorEx("999|1994|808081-101010,998|2019|808081-101010", 0.9) = 1 Then
        Touch 991, 2029, 20
        
    End If

End Function


Function closeComm()

    If hasShadowWindow() = False Then 
        Exit Function
    End If
   
    If CmpColorEx( 149 &"|"& 1030  & "|" & "F7F8F8-202020", 0.9 ) = 1 Then
        closeX()
        Touch 149, 1030, 100
        
    ElseIf CmpColorEx("257|1094|FFFFFF-202020", 0.9 ) = 1 Then 
        Touch 257,1094, 20
         
          
    ElseIf CmpColorEx("201|676|CECED0-202020", 0.9 ) = 1 Then 
        Touch 201,676, 20
 
    End If
End Function 

Function hasShadowWindow()
    If CmpColorEx("73|97|1A2A30-101010", 0.9 ) = 1 Then 
        hasShadowWindow = True
    Else 
        hasShadowWindow = False
    End If
        	
End Function


Function isInGameWindow()


    If CmpColorEx("71|106|7CCDF0-101010", 0.9) = 1 Then 
    	
        isInGameWindow = True
    ElseIf CmpColorEx("74|145|16262E-030303,119,1117|0A1621-030303", 0.9) = 1 Then
        //TracePrint 3333333333333333
        isInGameWindow = True
    ElseIf  CmpColorEx("999|1994|808081-101010,998|2019|808081-101010",0.9) = 1 Then
        //TracePrint 3333333333333333
        isInGameWindow = True
    Else 
        isInGameWindow = False
    End If
        	
End Function

// 广告处理
Function adProcc()
    TracePrint "开始广告处理................"
    Dim intX,intY
    // 存在倒计时形式的x按钮
    FindMultiColor 1063,1855,1215,2165,"000000","-9|47|000000,-31|86|FAFAFA,35|170|FAFAFA",0,1,intX,intY
    If intX > -1 And intY > -1 Then
        ShowMessage "暂时不关闭广告"
        Exit Function
    End If
    
    If  CmpColorEx("1171|78|FF7A00-101010,1166|145|FF7A00-101010,1189|109|FFFFFF",0.9) = 1 Then
	
        // 误入横版的app store 显示页面
        Touch 1171, 78, 20
		  
    ElseIf CmpColorEx("1126|2130|FFFFFF,1107|2111|FFFFFF,1123|2113|FFFFFF", 0.9) = 1 or CmpColorEx("1137|2102|FFFFFF-101010,1126|2113|F5F5F5-101010", 0.9) = 1 or CmpColorEx("1172|2116|FFFFFF-101010,1174|2138|FFFFFF-101010,1154|2136|FFFFFF-101010", 0.9) = 1 Then 
        TracePrint "关闭广告"
        Delay 1000
        Touch 1126, 2130, 20
        
    ElseIf CmpColorEx("1136|2128|686868,1137|2099|FFFFFF", 0.9) = 1 Then
        TracePrint "关闭广告2"
        Delay 1000
        Touch 1137, 2099, 20
        
    Else
    End If
  
End Function


Function heBingDengLongMain()
    // For ii = 1 To 12
    closeX ()
    closeComm()
    If hasShadowWindow() = False Then 
        hebingDengLong2()
        // moveToFirst (ii)
    Else 
        TracePrint "不合并"
    End If
    
        
    // Next 

End Function

 
If isInGameWindow() = False Then 
    TracePrint "不在游戏界面"
    ShowMessage "不在游戏界面"
    Delay 2000
    adProcc()
    
Else 
    heBingDengLongMain()
End If
