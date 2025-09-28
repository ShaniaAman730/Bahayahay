class TotalFileSizeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.attached?

    files = value.is_a?(Array) ? value : Array.wrap(value)

    total_size = files.sum { |file| file.blob.byte_size }

    if total_size > options[:less_than]
      record.errors.add(
        attribute,
        "total size must be less than #{options[:less_than] / 1.megabyte} MB"
      )
    end
  end
end

