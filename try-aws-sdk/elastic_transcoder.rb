require 'bundler/setup'
require 'aws-sdk'
require 'yaml'
require 'pp'

config = YAML.load File.read(File.join(File.dirname(__FILE__), 'aws.yml'))
AWS.config(config)

PIPELINE_ID = '0000000000000-xxxxxx'
INPUT_KEY = 'upload/sample.mp4'
OUTPUT_KEY = 'encoded/sample.mp4'
THUMBNAIL_PATTERN = 'encoded/sample-{count}'
PRESET_ID_SYSTEM_WEB = '1351620000001-100070'

transcoder = AWS::ElasticTranscoder::Client.new(api_version: '2012-09-25')

response = transcoder.create_job(
    pipeline_id: PIPELINE_ID,
    input: {
        key: INPUT_KEY,
        frame_rate: 'auto',
        resolution: 'auto',
        aspect_ratio: 'auto',
        interlaced: 'auto',
        container: 'auto'
    },
    output: {
        key: OUTPUT_KEY,
        preset_id: PRESET_ID_SYSTEM_WEB,
        thumbnail_pattern: THUMBNAIL_PATTERN,
        rotate: '0',
    }
)

# pp response #=> {
#     :job => {
#         :id => "0000000000000-xxxxxx",
#         :arn => "arn:aws:elastictranscoder:ap-northeast-1:000000000000:job/0000000000000-xxxxxx",
#         :pipeline_id => "0000000000000-xxxxxx",
#         :input => {
#             :key => "upload/sample.mp4",
#             :frame_rate => "auto",
#             :resolution => "auto",
#             :aspect_ratio => "auto",
#             :interlaced => "auto",
#             :container => "auto"
#         },
#         :output => {
#             :id => "1",
#             :key => "encoded/sample.mp4",
#             :thumbnail_pattern => "encoded/sample-{count}",
#             :rotate => "0",
#             :preset_id => "1351620000001-100070",
#             :status => "Submitted",
#             :watermarks => []
#         },
#         :outputs => [
#             {
#                 :id => "1",
#                 :key => "encoded/sample.mp4",
#                 :thumbnail_pattern => "encoded/sample-{count}",
#                 :rotate => "0",
#                 :preset_id => "1351620000001-100070",
#                 :status => "Progressing",
#                 :watermarks => []
#             }
#         ],
#         :playlists => [],
#         :status => "Submitted"
#     },
#     :request_id => "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
# }

while %w(Submitted Progressing).include?(response[:job][:status])
  if response[:job][:status] == 'Error' # Output Keyがすでに存在するなどエラーが発生したとき
    raise response[:job][:output][:status_detail]
  end
  sleep 10
  response = transcoder.read_job(id: response[:job][:id])
  puts response[:job][:status]
end

pp response
# pp response # => {
#     :job =>{
#         :id => "0000000000000-xxxxxx",
#         :arn => "arn:aws:elastictranscoder:ap-northeast-1:000000000000:job/0000000000000-xxxxxx",
#         :pipeline_id => "0000000000000-xxxxxx",
#         :input => {
#             :key => "upload/sample.mp4",
#             :frame_rate => "auto",
#             :resolution => "auto",
#             :aspect_ratio => "auto",
#             :interlaced => "auto",
#             :container => "auto"
#         },
#         :output => {
#             :id => "1",
#             :key => "encoded/sample.mp4",
#             :thumbnail_pattern => "encoded/sample-{count}",
#             :rotate => "0",
#             :preset_id => "1351620000001-100070",
#             :status => "Complete",
#             :duration => 372,
#             :width => 512,
#             :height => 384,
#             :watermarks => []
#         },
#         :outputs => [
#             {
#                 :id => "1",
#                 :key => "encoded/sample.mp4",
#                 :thumbnail_pattern => "encoded/sample-{count}",
#                 :rotate =>"0",
#                 :preset_id => "1351620000001-100070",
#                 :status => "Complete",
#                 :duration => 372,
#                 :width => 512,
#                 :height => 384,
#                 :watermarks => []
#             }
#         ],
#         :playlists => [],
#         :status => "Complete"
#     },
#     :request_id => "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
# }
