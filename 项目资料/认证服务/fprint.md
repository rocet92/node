fprint



1 纯c，glib，meson



apt install libgusb-dev libnss-dev libgtk-3-doc libpolkit-gobject-1-dev libpam-wrapper





libgusb



1，设备dbus服务怎么啦起来的

2，开源标准怎么找到寻址的

libgusb, 怎么区分设备，设备是否支持

3，对接设备驱动细节



gobject gtype gclass



fp-context.c 190 	 	




```c
// 1 - 插入usb指纹设备时的入口
// libfprint/fp-context.c
static void
fp_context_init (FpContext *self)
{
 // g_usb_context_new创建usb对象，这是libgusb库提供的函数，libgusb也是基于glib
 // 这里使用glib的信号机制，在有usb设备插入，usb对象会发出"device-added"信号
 priv->usb_ctx = g_usb_context_new (&error);
 if (!priv->usb_ctx)
  {
   g_message ("Could not initialise USB Subsystem: %s", error->message);
  }
 else
{

   // 响应"device-added"信号的函数usb_device_added_cb()

   g_signal_connect_object (priv->usb_ctx,

​                "device-added",

​                G_CALLBACK (usb_device_added_cb),

​                self,

​                G_CONNECT_SWAPPED);

  }

}
```