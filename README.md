Simply put this is a script to let you regenerate via WP-CLI all the PNG files uploaded after a certain date so that you can clean out a known PNG issue. This worked for me fine. YMMV. No warranty!

I generated it using some AI gizmos so I figured best to make it available to all of you.

# The PNG Bug

* the other people seeing problem is here - https://core.trac.wordpress.org/ticket/63448
* seeing if it is related to image_max_bit_depth probleim in https://make.wordpress.org/core/2025/03/25/miscellaneous-developer-changes-in-wordpress-6-8/#hdr-image-support-for-imagick-new-filter-to-control-maximum-bit-depth-of-resized-images

Rather woolly imagick stuff no one wants to think about but here we are. This script will fix the banding on your PNGs in WordPress.

# Note

You should change the table name from `FROM wp_posts` as needed.
