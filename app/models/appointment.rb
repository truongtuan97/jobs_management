class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :appointment_date, presence: true
  validates :status, inclusion: { in: %w[scheduled completed canceled] }

  scope :upcomming, -> { where('appointment_date >= ?', Time.current) }
  scope :completed, -> { where(status: 'completed') }
  scope :canceled, -> { where(status: 'canceled') }

  scope :by_doctor, ->(doctor_id) { where(doctor_id: doctor_id) }
  scope :by_patient, ->(patient_id) { where(patient_id: patient_id) }
  
  scope :by_date, ->(date) { where(appointment_date: date) }
  scope :by_status, ->(status) { where(status: status) }

  def self.by_doctor_name(name)
    doctor = Doctor.find_by(name: name)
    where(doctor_id: doctor.id)
  end

  def self.by_patient_name(name)
    patient = Patient.find_by(name: name)
    where(patient_id: patient.id)
  end

  def self.by_date_range(start_date, end_date)
    where(appointment_date: start_date..end_date)
  end

  def self.by_status(status)
    where(status: status)
  end
end
