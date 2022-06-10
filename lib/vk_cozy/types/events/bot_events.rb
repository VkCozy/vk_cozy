module VkCozy
	class BotEventType
		include Ruby::Enum

		define :MESSAGE_NEW, 'message_new'
		define :MESSAGE_REPLY, 'message_reply'
		define :MESSAGE_EDIT, 'message_edit'
		define :MESSAGE_EVENT, 'message_event'

		define :MESSAGE_TYPING_STATE, 'message_typing_state'

		define :MESSAGE_ALLOW, 'message_allow'

		define :MESSAGE_DENY, 'message_deny'

		define :PHOTO_NEW, 'photo_new'

		define :PHOTO_COMMENT_NEW, 'photo_comment_new'
		define :PHOTO_COMMENT_EDIT, 'photo_comment_edit'
		define :PHOTO_COMMENT_RESTORE, 'photo_comment_restore'

		define :PHOTO_COMMENT_DELETE, 'photo_comment_delete'

		define :AUDIO_NEW, 'audio_new'

		define :VIDEO_NEW, 'video_new'

   		define :VIDEO_COMMENT_NEW, 'video_comment_new'
		define :VIDEO_COMMENT_EDIT, 'video_comment_edit'
		define :VIDEO_COMMENT_RESTORE, 'video_comment_restore'

		define :VIDEO_COMMENT_DELETE, 'video_comment_delete'

		define :WALL_POST_NEW, 'wall_post_new'
		define :WALL_REPOST, 'wall_repost'

		define :WALL_REPLY_NEW, 'wall_reply_new'
		define :WALL_REPLY_EDIT, 'wall_reply_edit'
		define :WALL_REPLY_RESTORE, 'wall_reply_restore'

		define :WALL_REPLY_DELETE, 'wall_reply_delete'

		define :BOARD_POST_NEW, 'board_post_new'
		define :BOARD_POST_EDIT, 'board_post_edit'
		define :BOARD_POST_RESTORE, 'board_post_restore'

		define :BOARD_POST_DELETE, 'board_post_delete'

		define :MARKET_COMMENT_NEW, 'market_comment_new'
		define :MARKET_COMMENT_EDIT, 'market_comment_edit'
		define :MARKET_COMMENT_RESTORE, 'market_comment_restore'

		define :MARKET_COMMENT_DELETE, 'market_comment_delete'

		define :GROUP_LEAVE, 'group_leave'

		define :GROUP_JOIN, 'group_join'

		define :USER_BLOCK, 'user_block'

		define :USER_UNBLOCK, 'user_unblock'

		define :POLL_VOTE_NEW, 'poll_vote_new'

		define :GROUP_OFFICERS_EDIT, 'group_officers_edit'

		define :GROUP_CHANGE_SETTINGS, 'group_change_settings'

		define :GROUP_CHANGE_PHOTO, 'group_change_photo'
		
		define :VKPAY_TRANSACTION, 'vkpay_transaction'
	end
end