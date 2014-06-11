upload_dinner_photo = ->
    $(document).ready ->  
        updatePreview = (c) ->
            if parseInt(c.w) > 0
                rx = xsize / c.w #c.w是用户截图框框的宽度
                  #rx是预览元素的宽度（60）/用户截取的宽度的比例
                ry = ysize / c.h
                rx1 = xsize1 / c.w
                ry1 = ysize1 / c.h
                $pimg.css #$pimg.css的作用是把原图，按照（rx * boundx）等比例缩放了
                    width: Math.round(rx * boundx) + "px"
                    height: Math.round(ry * boundy) + "px"
                    marginLeft: "-" + Math.round(rx * c.x) + "px" #Math是JS内置对象，round（X）是把X四舍五入取最接近的数
                    marginTop: "-" + Math.round(ry * c.y) + "px"


                $('#preview_x').val(c.x)
                $('#preview_y').val(c.y)
                $('#preview_width').val(c.w)

        jcrop_api = undefined
        boundx = undefined
        boundy = undefined
        $preview = $("#preview-pane")
        $pcnt = $("#preview-pane .preview-container")
        $pimg = $("#preview-pane .preview-container img")
        xsize = $pcnt.width() #pcnt是preview-pane下preview-container这个元素,xsize也就是预览元素的宽度，可以自己设定
        ysize = $pcnt.height()

        api = $.Jcrop("#target",
            allowSelect: false,
            baseClass : "add"
        )