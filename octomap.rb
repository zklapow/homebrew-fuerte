
require 'formula'

class Octomap < Formula
  url 'git://github.com/ahornung/octomap.git', {:using => :git, :tag => 'upstream/1.4.1'}
  homepage 'http://octomap.sourceforge.net/'
  version '1.4.1'

  depends_on 'cmake'

  def patches
    DATA
  end

  def install
    ENV.universal_binary
    system "mkdir build"
    system "cd build && cmake .. #{std_cmake_parameters}"
    system "cd build && make install"
  end

end

__END__
diff --git a/include/octomap/OccupancyOcTreeBase.hxx b/include/octomap/OccupancyOcTreeBase.hxx
index 0b7197f..360f9c0 100644
--- a/include/octomap/OccupancyOcTreeBase.hxx
+++ b/include/octomap/OccupancyOcTreeBase.hxx
@@ -363,12 +363,12 @@ namespace octomap {
       if (isNodeOccupied(startingNode)){
         // Occupied node found at origin 
         // (need to convert from key, since origin does not need to be a voxel center)
-        genCoords(current_key, this->tree_depth, end);
+        this->genCoords(current_key, this->tree_depth, end);
         return true;
       }
     } else if(!ignoreUnknown){
       OCTOMAP_ERROR_STR("Origin node at " << origin << " for raycasting not found, does the node exist?");
-      genCoords(current_key, this->tree_depth, end);
+      this->genCoords(current_key, this->tree_depth, end);
       return false;
     }
 
@@ -435,7 +435,7 @@ namespace octomap {
       {
          OCTOMAP_WARNING("Coordinate hit bounds in dim %d, aborting raycast\n", dim);
          // return border point nevertheless:
-         genCoords(current_key, this->tree_depth, end);
+         this->genCoords(current_key, this->tree_depth, end);
          return false;
       }
 

