module VkCozy
  class UserEventType < Inum::Base
    define :UNDEFINED_EVENT, -1

    define :REPLACE_MESSAGE_FLAGS, 1
    define :INSTALL_MESSAGE_FLAGS, 2
    define :RESET_MESSAGE_FLAGS, 3

    define :MESSAGE_NEW, 4
    define :MESSAGE_EDIT, 5
    define :IN_READ, 6
    define :OUT_READ, 7
    define :FRIEND_ONLINE, 8
    define :FRIEND_OFFLINE, 9
    define :RESET_DIALOG_FLAGS, 10
    define :REPLACE_DIALOG_FLAGS, 11
    define :INSTALL_DIALOG_FLAGS, 12
    define :MESSAGES_DELETE, 13
    define :MESSAGES_RESTORE, 14

    define :MESSAGE_CHANGE, 18
    define :CLEAR_MESSAGE_CACHE, 19

    define :CHANGE_MAJOR_ID, 20
    define :CHANGE_MINOR_ID, 21

    define :CHAT_EDIT, 51
    define :CHAT_INFO_EDIT, 52
    define :DIALOG_TYPING_STATE, 61

    define :CHAT_TYPING_STATE, 62
    define :USERS_TYPING_STATE, 63
    define :CHAT_VOICE_MESSAGE_STATES, 64
    define :PHOTO_UPLOAD_STATE, 65
    define :VIDEO_UPLOAD_STATE, 66
    define :FILE_UPLOAD_STAE, 67

    define :CALL, 70
    define :COUNTER, 80
    define :USER_INVISIBLE_CHANGE, 81
    define :NOTIFICATIONS_SETTINGS_CHANGED, 114
    define :CHAT_CALL, 115
    define :CALLBACK_BUTTON_REPLY, 119
  end

  MESSAGE_EXTRA_FIELDS = [
    'peer_id', 'timestamp', 'text', 'extra_values', 'attachments', 'random_id'
  ]
  MSGID = 'message_id'
  EVENT_ATTRS_MAPPING = {
    VkCozy::UserEventType::REPLACE_MESSAGE_FLAGS => [MSGID, 'flags'] + MESSAGE_EXTRA_FIELDS,
    VkCozy::UserEventType::INSTALL_MESSAGE_FLAGS => [MSGID, 'mask'] + MESSAGE_EXTRA_FIELDS,
    VkCozy::UserEventType::RESET_MESSAGE_FLAGS => [MSGID, 'mask'] + MESSAGE_EXTRA_FIELDS,
    VkCozy::UserEventType::MESSAGE_NEW => [MSGID, 'flags'] + MESSAGE_EXTRA_FIELDS,
    VkCozy::UserEventType::MESSAGE_EDIT => [MSGID, 'mask'] + MESSAGE_EXTRA_FIELDS,
    VkCozy::UserEventType::IN_READ => ['peer_id', 'local_id'],
    VkCozy::UserEventType::OUT_READ => ['peer_id', 'local_id'],
    VkCozy::UserEventType::FRIEND_ONLINE => ['user_id', 'extra', 'timestamp'],
    VkCozy::UserEventType::FRIEND_OFFLINE => ['user_id', 'flags', 'timestamp'],
    VkCozy::UserEventType::DIALOG_TYPING_STATE => ['user_id', 'flags']
  }
  PARSE_PEER_ID_EVENTS = EVENT_ATTRS_MAPPING.map{|k, v| if v.include?('peer_id') then k end}.select{ |i| not i.nil? }
  PARSE_MESSAGE_FLAGS_EVENTS = [
    VkCozy::UserEventType::REPLACE_MESSAGE_FLAGS,
    VkCozy::UserEventType::MESSAGE_NEW
  ]
end