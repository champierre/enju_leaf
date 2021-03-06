# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Subject do
  fixtures :subjects

  it "should get term" do
    subjects(:subject_00001).term.should be_true
  end
end

# == Schema Information
#
# Table name: subjects
#
#  id                      :integer         not null, primary key
#  parent_id               :integer
#  use_term_id             :integer
#  term                    :string(255)
#  term_transcription      :text
#  subject_type_id         :integer         not null
#  scope_note              :text
#  note                    :text
#  required_role_id        :integer         default(1), not null
#  work_has_subjects_count :integer         default(0), not null
#  lock_version            :integer         default(0), not null
#  created_at              :datetime
#  updated_at              :datetime
#  deleted_at              :datetime
#

