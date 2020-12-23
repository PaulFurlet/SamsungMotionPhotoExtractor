# Samsung Motion Photo Extractor
Used to extract photo and video from MotionPhoto files done by Samsung phones (maybe some other vendors do that as well, I did not research)


## Usage
AutoIt3 _SamsungMotionPhotoExtractor.au3_ {FileName}.jpg

## Result
Two new files created in the folder where original file exist:
* {FileName}_cut.jpg
* {FileName}_cut.mp4

## Notes
Work is done by searching **MotionPhoto_Data** string marker and splitting original file on two files by it.
