upload_photo = (callback)->
    $(document).ready ->  
        $("#save_photo").click ->
            $("#to_save_phpto_from").submit()
        $("#userphpto_sub").click ->
            $("#file").click()
        $("#file").change ->
            $("#upload_img").submit()
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
                $pimg1.css 
                    width: Math.round(rx1 * boundx) + "px"
                    height: Math.round(ry1 * boundy) + "px"
                    marginLeft: "-" + Math.round(rx1 * c.x) + "px" #Math是JS内置对象，round（X）是把X四舍五入取最接近的数
                    marginTop: "-" + Math.round(ry1 * c.y) + "px"
                console.log c.x, c.y, c.w, c
                $('#preview_x').val(c.x)
                $('#preview_y').val(c.y)
                $('#preview_width').val(c.w)

        jcrop_api = undefined
        boundx = undefined
        boundy = undefined
        $preview = $("#preview-pane")
        $pcnt = $("#preview-pane .preview-container")
        $pcnt1 = $("#preview-pane .preview-container1")
        $pimg = $("#preview-pane .preview-container img")
        $pimg1 = $("#preview-pane .preview-container1 img")
        xsize = $pcnt.width() #pcnt是preview-pane下preview-container这个元素,xsize也就是预览元素的宽度，可以自己设定
        ysize = $pcnt.height()
        xsize1 = $pcnt1.width()
        ysize1 = $pcnt1.height()
        $("#target").Jcrop
            onChange: updatePreview
            onSelect: updatePreview
            aspectRatio: 1 / 1
            setSelect: [0, 0, 200, 200]
        , ->
            bounds = @getBounds() #@getBounds()返回的是当前加载图片的分辨率
            boundx = bounds[0] #当前图片的宽
            boundy = bounds[1] # 当前图片的长
            jcrop_api = this
            $preview.appendTo jcrop_api.ui.holder
            callback()
get_photo_size = ->
    $(document).ready ->  
        console.log "get_photo_size"
        console.log $(".jcrop-holder")[0]
        phpto1_heigh = undefined
        phpto1_width = undefined
        phpto2_heigh = undefined
        phpto2_width = undefined
        phpto3_heigh = undefined
        phpto3_width = undefined
        # $(".jcrop-hline").css "width", "100"
        # $(".jcrop-hline bottom").css "width", "100"
        # $(".jcrop-vline right").css "height", "100"
        # $(".jcrop-vline").css "height", "100"
preview_photo = ->
    $(document).ready ->  
        $("#userphpto_sub").click ->
            $("#file").click()
        $("#file").change ->
            $("#upload_img").submit()