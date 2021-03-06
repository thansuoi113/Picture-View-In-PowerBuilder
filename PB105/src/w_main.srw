$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type p_1 from picture within w_main
end type
type cb_setbackcolor from commandbutton within w_main
end type
type st_2 from statictext within w_main
end type
type sle_title from singlelineedit within w_main
end type
type cb_select_file from commandbutton within w_main
end type
type st_1 from statictext within w_main
end type
type sle_pic_file from singlelineedit within w_main
end type
type dw_view from uo_picture_view within w_main
end type
end forward

global type w_main from window
integer width = 3141
integer height = 2184
boolean titlebar = true
string title = "DataWindow Image Viewer Control"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
p_1 p_1
cb_setbackcolor cb_setbackcolor
st_2 st_2
sle_title sle_title
cb_select_file cb_select_file
st_1 st_1
sle_pic_file sle_pic_file
dw_view dw_view
end type
global w_main w_main

forward prototypes
public subroutine wf_show_picture (string as_pic_name, string as_title)
public subroutine wf_center (window aw_window)
end prototypes

public subroutine wf_show_picture (string as_pic_name, string as_title);If Not FileExists(as_pic_name) Then Return
p_1.PictureName = as_pic_name
p_1.OriginalSize = True
//dw_view.uf_setpicsize(pixelstounits(p_1.width,xpixelstounits!),pixelstounits(p_1.height,ypixelstounits!))
dw_view.uf_setpicsize(p_1.Width,p_1.Height)
dw_view.uf_setfileName(as_pic_name)
dw_view.uf_settitle(as_title)

end subroutine

public subroutine wf_center (window aw_window);//====================================================================
// Function: w_main.wf_center()
//--------------------------------------------------------------------
// Description: Make the window appear in the center of the screen
//--------------------------------------------------------------------
// Arguments:
// 	value	window	aw_window	window to be displayed
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/02/20
//--------------------------------------------------------------------
// Usage: w_main.wf_center ( window aw_window )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Environment l_Env

// get environment, in order to get screen size
Integer li_Rtn
li_Rtn = GetEnvironment(l_Env)

// Determine whether the environment variable can be obtained correctly
//DEBUG_ASSERT((li_Rtn=1),"Can't get Environment!")

// convert screen pixels to pb uint
Integer li_ScreenHeight, li_ScreenWidth
li_ScreenWidth = PixelsToUnits(l_Env.ScreenWidth, XPixelsToUnits!)
li_ScreenHeight = PixelsToUnits(l_Env.ScreenHeight, YPixelsToUnits!)

// calc window postion
Integer li_X, li_Y
li_X = (li_ScreenWidth - aw_window.Width)/2
li_Y = (li_ScreenHeight - aw_window.Height)*2/5 // make it cool

// repositioning window
aw_window.Move(li_X, li_Y)

end subroutine

on w_main.create
this.p_1=create p_1
this.cb_setbackcolor=create cb_setbackcolor
this.st_2=create st_2
this.sle_title=create sle_title
this.cb_select_file=create cb_select_file
this.st_1=create st_1
this.sle_pic_file=create sle_pic_file
this.dw_view=create dw_view
this.Control[]={this.p_1,&
this.cb_setbackcolor,&
this.st_2,&
this.sle_title,&
this.cb_select_file,&
this.st_1,&
this.sle_pic_file,&
this.dw_view}
end on

on w_main.destroy
destroy(this.p_1)
destroy(this.cb_setbackcolor)
destroy(this.st_2)
destroy(this.sle_title)
destroy(this.cb_select_file)
destroy(this.st_1)
destroy(this.sle_pic_file)
destroy(this.dw_view)
end on

event resize;dw_view.Width = WorkSpaceWidth() - dw_view.X *2
dw_view.Height = WorkSpaceHeight() - dw_view.Y - 8

end event

event open;wf_center(This)
dw_view.uf_setzoomscalestep(0.1)
dw_view.uf_setzoomscale(1.0)
wf_show_picture(sle_pic_file.text,sle_title.text)

dw_view.event clicked(1680,18,0,dw_view.object.b_all)
end event

type p_1 from picture within w_main
boolean visible = false
integer x = 2290
integer width = 110
integer height = 88
boolean originalsize = true
boolean focusrectangle = false
end type

type cb_setbackcolor from commandbutton within w_main
integer x = 1737
integer y = 116
integer width = 923
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Random Background Color Settings"
end type

event clicked;dw_view.uf_setbackcolor(rgb(rand(255),rand(255),rand(255)))

end event

type st_2 from statictext within w_main
integer x = 27
integer y = 112
integer width = 187
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Title:"
boolean focusrectangle = false
end type

type sle_title from singlelineedit within w_main
integer x = 215
integer y = 108
integer width = 1477
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "picview.bmp"
borderstyle borderstyle = stylelowered!
end type

event modified;dw_view.uf_settitle(sle_title.text)
end event

type cb_select_file from commandbutton within w_main
integer x = 1737
integer y = 8
integer width = 306
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Choose..."
end type

event clicked;string ls_PathName,ls_FileName
integer li_Rtn

li_Rtn = GetFileOpenName("Select image file", ls_PathName, ls_FileName,'bmp',&
"Supported image formats,*.jpg;*.bmp;*.gif;*.rle;*.wmf,"+&
"Bitmap(.bmp),*.bmp,"+&
"JPEG(.jpg;.jpeg),*.jpg;*.jpeg,"+&
"RunLengthEncode(.rle),*.rle,"+&
"Windows MetaFile(.wmf),*.wmf")

IF li_Rtn <> 1 THEN  return
sle_pic_file.text = ls_PathName
sle_title.text = ls_FileName

wf_show_picture(ls_pathName,ls_fileName)
end event

type st_1 from statictext within w_main
integer x = 27
integer y = 20
integer width = 187
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "File:"
boolean focusrectangle = false
end type

type sle_pic_file from singlelineedit within w_main
integer x = 215
integer y = 12
integer width = 1477
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "picview.bmp"
borderstyle borderstyle = stylelowered!
end type

event modified;wf_show_picture(this.text,sle_title.text)
end event

type dw_view from uo_picture_view within w_main
integer x = 9
integer y = 216
integer width = 2574
integer height = 1300
integer taborder = 10
boolean titlebar = false
boolean resizable = false
borderstyle borderstyle = stylelowered!
end type

