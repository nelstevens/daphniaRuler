# measure_directory works

    Code
      measure_directory(corrpath_dir, write_images = F, eye_method = F)
    Output
      [[1]]
      [[1]]$ID
      [1] "sample_images\\example1.JPG"
      
      [[1]]$perimeter
      [1] 1038.189
      
      [[1]]$area
      [1] 65656.89
      
      [[1]]$minor
      [1] 207.7907
      
      [[1]]$solidity
      [1] 0.9870644
      
      [[1]]$full.Length
      [1] 406.9933
      
      
      [[2]]
      [[2]]$ID
      [1] "sample_images\\example_head.JPG"
      
      [[2]]$perimeter
      [1] 1703.045
      
      [[2]]$area
      [1] 154247.1
      
      [[2]]$minor
      [1] 334.2006
      
      [[2]]$solidity
      [1] 0.9341516
      
      [[2]]$full.Length
      [1] 597.2689
      
      

---

    Code
      measure_directory(corrpath_dir, write_images = F, eye_method = T)
    Output
      [[1]]
      [[1]]$ID
      [1] "sample_images\\example1.JPG"
      
      [[1]]$perimeter
      [1] 1038.189
      
      [[1]]$area
      [1] 65656.89
      
      [[1]]$minor
      [1] 207.7907
      
      [[1]]$solidity
      [1] 0.9870644
      
      [[1]]$full.Length
      [1] 406.9933
      
      [[1]]$tail.Length
      [1] 124.5079
      
      [[1]]$eye.Length
      [1] 354.1952
      
      [[1]]$tail.angle
      [1] 159.6364
      
      
      [[2]]
      [[2]]$ID
      [1] "sample_images\\example_head.JPG"
      
      [[2]]$perimeter
      [1] 1703.045
      
      [[2]]$area
      [1] 154247.1
      
      [[2]]$minor
      [1] 334.2006
      
      [[2]]$solidity
      [1] 0.9341516
      
      [[2]]$full.Length
      [1] 597.2689
      
      

---

    Code
      measure_directory(corrpath_dir, write_images = T, eye_method = F)
    Output
      [[1]]
      [[1]]$ID
      [1] "sample_images\\example1.JPG"
      
      [[1]]$perimeter
      [1] 1038.189
      
      [[1]]$area
      [1] 65656.89
      
      [[1]]$minor
      [1] 207.7907
      
      [[1]]$solidity
      [1] 0.9870644
      
      [[1]]$full.Length
      [1] 406.9933
      
      
      [[2]]
      [[2]]$ID
      [1] "sample_images\\example_head.JPG"
      
      [[2]]$perimeter
      [1] 1703.045
      
      [[2]]$area
      [1] 154247.1
      
      [[2]]$minor
      [1] 334.2006
      
      [[2]]$solidity
      [1] 0.9341516
      
      [[2]]$full.Length
      [1] 597.2689
      
      

---

    Code
      measure_directory(corrpath_dir, write_images = T, eye_method = T)
    Output
      [[1]]
      [[1]]$ID
      [1] "sample_images\\example1.JPG"
      
      [[1]]$perimeter
      [1] 1038.189
      
      [[1]]$area
      [1] 65656.89
      
      [[1]]$minor
      [1] 207.7907
      
      [[1]]$solidity
      [1] 0.9870644
      
      [[1]]$full.Length
      [1] 406.9933
      
      [[1]]$tail.Length
      [1] 124.5079
      
      [[1]]$eye.Length
      [1] 354.1952
      
      [[1]]$tail.angle
      [1] 159.6364
      
      
      [[2]]
      [[2]]$ID
      [1] "sample_images\\example_head.JPG"
      
      [[2]]$perimeter
      [1] 1703.045
      
      [[2]]$area
      [1] 154247.1
      
      [[2]]$minor
      [1] 334.2006
      
      [[2]]$solidity
      [1] 0.9341516
      
      [[2]]$full.Length
      [1] 597.2689
      
      

