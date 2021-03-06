$PBExportHeader$uo_picture_view.sru
forward
global type uo_picture_view from datawindow
end type
end forward

global type uo_picture_view from datawindow
integer width = 2514
integer height = 1412
boolean titlebar = true
string title = "Picture View"
string dataobject = "d_picture_view"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean livescroll = true
event ue_leftbuttondown pbm_lbuttondown
event ue_mousemoving pbm_mousemove
event ue_leftbuttonup pbm_lbuttonup
end type
global uo_picture_view uo_picture_view

type variables
Private:
String is_picture_FileName
String is_curs_moving,is_curs_moved,is_curs_zoomin,is_curs_zoomout
Boolean ib_photo_moving,ib_zoomin,ib_zoomout,ib_DoNothing = False
Integer ii_lbuttondown_posx,ii_lbuttondown_posy,ii_pic_width,ii_pic_height
Dec{2} id_scale_step = 0.25 ,id_cur_scale = 1.00


end variables
forward prototypes
public subroutine uf_settitle (string as_title)
public function boolean uf_setfilename (string as_filename)
public subroutine uf_setzoomscalestep (decimal ai_newscale)
public subroutine uf_setpicsize (integer ai_pic_width, integer ai_pic_height)
public subroutine uf_setzoomscale (decimal ai_newscale)
public subroutine uf_setbackcolor (long al_back_color)
end prototypes

event ue_leftbuttondown;If xpos > 1200 And xpos < 1800 And ypos >= 20 And ypos <= 84 Then
	ib_DoNothing = True
	Return
End If
If ib_DoNothing Then Return
If Not ib_zoomin And Not ib_zoomout Then
	ib_photo_moving = True
	ii_lbuttondown_posx = xpos
	ii_lbuttondown_posy = ypos
	This.Object.datawindow.Pointer = is_curs_moving
	This.Object.p_photo_view.Pointer = is_curs_moving
Else
	ib_photo_moving = False
	//	this.object.datawindow.pointer = is_curs_moved
	//	this.object.p_photo_view.pointer = is_curs_moved
End If

end event

event ue_mousemoving;This.Object.t_posx.Text = String(xpos)
This.Object.t_posy.Text = String(ypos)

If ib_DoNothing Then Return

If Not ib_photo_moving Then Return
Integer li_picx,li_picy
Integer li_movex,li_movey

li_picx = Integer(This.Object.p_photo_view.X)
li_picy = Integer(This.Object.p_photo_view.Y)
li_movex = xpos - ii_lbuttondown_posx
li_movey = ypos - ii_lbuttondown_posy
This.SetRedraw(False)
This.Object.p_photo_view.X = li_picx + li_movex
This.Object.p_photo_view.Y = li_picy + li_movey
This.SetRedraw(True)
ii_lbuttondown_posx = xpos
ii_lbuttondown_posy = ypos

end event

event ue_leftbuttonup;If xpos > 1200 And xpos < 1800 And ypos >= 20 And ypos <= 84 Then Return

If ib_DoNothing Then Return
If Not ib_zoomin And Not ib_zoomout Then
	ib_photo_moving = False
	This.Object.p_photo_view.Pointer = is_curs_moved
	This.Object.datawindow.Pointer = is_curs_moved
	Return
End If
If ii_pic_width <= 0 Then Return
If ib_zoomin Then
	id_cur_scale = id_cur_scale + id_scale_step
End If
If ib_zoomout Then
	id_cur_scale = id_cur_scale * (1 - id_scale_step)
End If
If id_cur_scale >= 8.0 Or id_cur_scale <= 0.05 Then Return

Long li_new_x,li_new_y,li_new_width,li_new_height
Long li_x0,li_y0,li_old_width,li_old_height,li_addx,li_addy
//Double lf_tgn,ld_addx,ld_addy,ld_sin,ld_cos,ld_len

This.SetRedraw(False)
li_x0 = Long(This.Object.p_photo_view.X)
li_y0 = Long(This.Object.p_photo_view.Y)
li_old_width = Long(This.Object.p_photo_view.Width)
li_old_height = Long(This.Object.p_photo_view.Height)

li_new_width  = ii_pic_width * id_cur_scale
li_new_height = ii_pic_height * id_cur_scale
/*
ld_len = sqrt((xpos - li_x0)*(xpos - li_x0) + (ypos - li_y0) * (ypos - li_y0))
ld_sin = ( ypos - li_y0)/ld_len
ld_cos = ( xpos - li_x0)/ld_len
debugbreak()
*/
li_addx = (xpos - li_x0) * (id_cur_scale -1)
li_addy = (ypos - li_y0) * (id_cur_scale -1)

li_new_x = li_x0 - li_addx
li_new_y = li_y0 - li_addy

This.Object.t_scale.Text = String(id_cur_scale,'##0%')
//this.object.p_photo_view.x = li_new_x
//this.object.p_photo_view.y = li_new_y

This.Object.p_photo_view.Width = li_new_width
This.Object.p_photo_view.Height = li_new_height
This.SetRedraw(True)

end event

public subroutine uf_settitle (string as_title);this.object.st_title.text = as_Title

end subroutine

public function boolean uf_setfilename (string as_filename);if FileExists(as_filename) then 
	this.object.p_photo_view.visible = 0
	this.object.p_photo_view.Filename = as_fileName
	this.object.p_photo_view.visible = 1
	return True
else
	this.object.p_photo_view.FileName = 'LiuFang'
	return True
end if

end function

public subroutine uf_setzoomscalestep (decimal ai_newscale);id_scale_step = ai_newscale
end subroutine

public subroutine uf_setpicsize (integer ai_pic_width, integer ai_pic_height);this.setredraw(false)
this.object.p_photo_view.width  = ai_pic_width
this.object.p_photo_view.height = ai_pic_height
ii_pic_width = ai_pic_width
ii_pic_height = ai_pic_height
this.object.t_scale.text = '100%'
this.setredraw(true)
end subroutine

public subroutine uf_setzoomscale (decimal ai_newscale);id_cur_scale = ai_newScale

if id_cur_scale >= 8.0 or id_cur_scale <= 0.05 then return

Long li_new_x,li_new_y,li_new_width,li_new_height
Long li_x0,li_y0,li_old_width,li_old_height,li_addx,li_addy
//Double lf_tgn,ld_addx,ld_addy,ld_sin,ld_cos,ld_len

this.setredraw(false)
li_x0 = Long(this.object.p_photo_view.x)
li_y0 = Long(this.object.p_photo_view.y)
li_old_width = Long(this.object.p_photo_view.width)
li_old_height= Long(this.object.p_photo_view.height)

li_new_width  = ii_pic_width * id_cur_scale
li_new_height = ii_pic_height * id_cur_scale

//li_addx = (xpos - li_x0) * (id_cur_scale -1)
//li_addy = (ypos - li_y0) * (id_cur_scale -1)

li_new_x = li_x0 //- li_addx
li_new_y = li_y0 //- li_addy

this.object.t_scale.text = string(id_cur_scale,'##0%')
//this.object.p_photo_view.x = li_new_x
//this.object.p_photo_view.y = li_new_y

this.object.p_photo_view.width = li_new_width
this.object.p_photo_view.height = li_new_height
this.setredraw(true)
end subroutine

public subroutine uf_setbackcolor (long al_back_color);this.modify('datawindow.header.color='+string(al_back_color))

end subroutine

on uo_picture_view.create
end on

on uo_picture_view.destroy
end on

event constructor;is_curs_moved = "hand.cur"
is_curs_moving = "hand2.cur"
is_curs_zoomin = 'zoomin.cur'
is_curs_zoomout = 'zoomout.cur'

end event

event clicked;//====================================================================
// Event: uo_picture_view.clicked()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer 	xpos	
// 	value	integer 	ypos	
// 	value	long    	row 	
// 	value	dwobject	dwo 	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/02/20
//--------------------------------------------------------------------
// Usage: uo_picture_view.clicked for uo_picture_view
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//if NOT( xpos > 1200 and xpos < 1800 and ypos >= 20 and ypos <= 84 ) then return

ib_DoNothing = True
String ls_button_name,ls_modify
ls_button_name = dwo.Name
If ls_button_name = 'b_all' Then
	This.SetRedraw(False)
	This.Object.p_photo_view.X = 41
	This.Object.p_photo_view.Y = 104
	This.Object.p_photo_view.Width = ii_pic_width
	This.Object.p_photo_view.Height = ii_pic_height
	This.Object.t_scale.Text = '100%'
	id_cur_scale = 1.00
	This.SetRedraw(True)
	ib_DoNothing = False
	Return
End If
If ls_button_name = 'b_left' Then
	This.SetRedraw(False)
	Long ll_width,ll_height
	ll_width = Long(This.Object.p_photo_view.Width)
	ll_height = Long(This.Object.p_photo_view.Height)
	This.Object.p_photo_view.X = Integer((This.Width - ll_width )/2)
	This.Object.p_photo_view.Y = Integer((This.Height - ll_height)/2)
	This.SetRedraw(True)
	ib_DoNothing = False
	Return
End If
If ls_button_name = 'p_zoomin' Then
	ib_photo_moving = False
	ib_zoomin = Not ib_zoomin
	ib_zoomout = False
	If ib_zoomin Then
		This.Object.datawindow.Pointer = is_curs_zoomin
		This.Object.p_photo_view.Pointer = is_curs_zoomin
	Else
		This.Object.datawindow.Pointer = is_curs_moved
		This.Object.p_photo_view.Pointer = is_curs_moved
	End If
End If
If ls_button_name = 'p_zoomout' Then
	ib_photo_moving = False
	ib_zoomout = Not ib_zoomout
	ib_zoomin  = False
	If ib_zoomout Then
		This.Object.datawindow.Pointer = is_curs_zoomout
		This.Object.p_photo_view.Pointer = is_curs_zoomout
	Else
		This.Object.datawindow.Pointer = is_curs_moved
		This.Object.p_photo_view.Pointer = is_curs_moved
	End If
End If
If ls_button_name = 'p_move' Then
	ib_zoomout = False
	ib_zoomin  = False
End If
String ls_bn = "6",ls_bs = "5"
If ib_zoomout Then
	ls_modify += ' p_zoomout.border="'+ls_bs+'" p_move.border="'+ls_bn+'" '
Else
	ls_modify += ' p_zoomout.border="'+ls_bn+'" '
End If
If ib_zoomin  Then
	ls_modify += ' p_zoomin.border ="'+ls_bs+'" p_move.border="'+ls_bn+'" '
Else
	ls_modify += ' p_zoomin.border ="'+ls_bn+'" '
End If
If Not ib_zoomout And Not ib_zoomin Then
	ls_modify += ' p_move.border="'+ls_bs+'" '
Else
	ls_modify += ' p_move.border="'+ls_bn+'" '
End If
This.Modify(ls_modify)
ib_DoNothing = False


end event

event rbuttondown;String ls_bn = "6",ls_bs = "5" ,ls_modify
ib_zoomout = False
ib_zoomin  = False
If ib_zoomout Then
	ls_modify += ' p_zoomout.border="'+ls_bs+'" p_move.border="'+ls_bn+'" '
Else
	ls_modify += ' p_zoomout.border="'+ls_bn+'" '
End If
If ib_zoomin  Then
	ls_modify += ' p_zoomin.border ="'+ls_bs+'" p_move.border="'+ls_bn+'" '
Else
	ls_modify += ' p_zoomin.border ="'+ls_bn+'" '
End If
If Not ib_zoomout And Not ib_zoomin Then
	ls_modify += ' p_move.border="'+ls_bs+'" '
Else
	ls_modify += ' p_move.border="'+ls_bn+'" '
End If
This.Modify(ls_modify)
This.Object.p_photo_view.Pointer = is_curs_moved
This.Object.datawindow.Pointer = is_curs_moved

ib_DoNothing = False

end event

