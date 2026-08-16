-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0162_ci_security_surveillance_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Security / Surveillance
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--
-- Representative role validation:
--   Technician I — Entry Level                 -> Level 1
--   Technician II — Experienced                    -> Level 2
--   Technician III — Lead Technician                 -> Level 3
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess security and surveillance fundamentals,
-- intrusion detection, camera coverage, recording, retention, supervision, permissions,
-- troubleshooting, integration, cybersecurity, and progressively higher systems judgment.
-- ============================================================================

begin;

create temporary table _seed_ci_security_surveillance_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_security_surveillance_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a security or surveillance system?',
  '[{"key":"A","text":"To monitor, detect, record, or help respond to security-related events"},{"key":"B","text":"To provide whole-home audio amplification"},{"key":"C","text":"To control HVAC airflow"},{"key":"D","text":"To replace all network infrastructure"}]'::jsonb,
  '["A"]'::jsonb,
  'Security and surveillance systems are designed to monitor spaces, detect events, record activity, and support response or investigation.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a surveillance camera?',
  '[{"key":"A","text":"To capture video of an area for live viewing or recording"},{"key":"B","text":"To provide line-voltage power to lighting circuits"},{"key":"C","text":"To distribute audio signals"},{"key":"D","text":"To assign IP addresses to network devices"}]'::jsonb,
  '["A"]'::jsonb,
  'A surveillance camera captures video so an area can be monitored live or reviewed later.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is an NVR commonly used for in an IP surveillance system?',
  '[{"key":"A","text":"To record and manage video streams from network cameras"},{"key":"B","text":"To dim lighting loads"},{"key":"C","text":"To terminate speaker wire"},{"key":"D","text":"To provide thermostat control"}]'::jsonb,
  '["A"]'::jsonb,
  'A network video recorder stores and manages video streams from IP-based surveillance cameras.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of a door or window contact in a security system?',
  '[{"key":"A","text":"To detect whether the protected opening is open or closed"},{"key":"B","text":"To measure audio volume"},{"key":"C","text":"To provide wireless internet access"},{"key":"D","text":"To switch video sources"}]'::jsonb,
  '["A"]'::jsonb,
  'A contact sensor reports the state of an opening so the security system can detect an open or closed condition.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What does a motion detector commonly detect?',
  '[{"key":"A","text":"Movement within a protected area"},{"key":"B","text":"Network bandwidth usage"},{"key":"C","text":"Speaker impedance"},{"key":"D","text":"Lighting load wattage"}]'::jsonb,
  '["A"]'::jsonb,
  'Motion detectors are used to detect movement within their coverage area.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'Why is camera field of view important?',
  '[{"key":"A","text":"It determines what area the camera can actually see and record"},{"key":"B","text":"It determines the audio amplifier gain"},{"key":"C","text":"It sets the network subnet mask"},{"key":"D","text":"It controls the alarm siren volume"}]'::jsonb,
  '["A"]'::jsonb,
  'Field of view determines the visible coverage area and directly affects whether the intended scene is captured.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What is the purpose of labeling security and surveillance cabling?',
  '[{"key":"A","text":"To identify cable destinations, devices, zones, and system relationships consistently"},{"key":"B","text":"To increase camera resolution"},{"key":"C","text":"To eliminate the need for testing"},{"key":"D","text":"To improve detector sensitivity automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent labeling supports installation accuracy, troubleshooting, documentation, and future service.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why should a technician follow the project security or surveillance drawing during installation?',
  '[{"key":"A","text":"To place devices and cabling according to the intended system design and coverage plan"},{"key":"B","text":"To choose random device locations"},{"key":"C","text":"To avoid documenting changes"},{"key":"D","text":"To bypass device testing"}]'::jsonb,
  '["A"]'::jsonb,
  'Project drawings communicate intended locations, coverage, cabling paths, and system relationships.'
),
(
  9,
  'multiple_choice',
  'application',
  'A newly installed camera powers on but shows no image at the recorder. What should the technician check first?',
  '[{"key":"A","text":"The camera connection, power or PoE status, network link, and recorder association"},{"key":"B","text":"The speaker polarity"},{"key":"C","text":"The lighting scene programming"},{"key":"D","text":"The thermostat schedule"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic camera troubleshooting should start with power, connectivity, link status, and whether the camera is properly associated with the recording system.'
),
(
  10,
  'multiple_choice',
  'application',
  'A door contact always shows open even when the door is closed. What should the technician verify?',
  '[{"key":"A","text":"Contact alignment, wiring, termination, and the zone configuration"},{"key":"B","text":"Camera zoom"},{"key":"C","text":"Speaker balance"},{"key":"D","text":"Wireless channel width"}]'::jsonb,
  '["A"]'::jsonb,
  'An incorrect open state can result from physical alignment, wiring, termination, or incorrect zone configuration.'
),
(
  11,
  'multiple_choice',
  'application',
  'A camera view does not show the doorway it was intended to monitor. What is the BEST corrective action?',
  '[{"key":"A","text":"Adjust the camera position or field of view to match the documented coverage requirement"},{"key":"B","text":"Increase the alarm siren volume"},{"key":"C","text":"Change the recorder password only"},{"key":"D","text":"Move an unrelated motion detector"}]'::jsonb,
  '["A"]'::jsonb,
  'Camera placement and aiming should be adjusted so the intended area is actually visible and usable.'
),
(
  12,
  'multiple_choice',
  'application',
  'A motion detector generates false alarms near a moving heat source. What should the technician review?',
  '[{"key":"A","text":"Detector placement, environmental conditions, coverage pattern, and manufacturer guidance"},{"key":"B","text":"The television resolution"},{"key":"C","text":"The network printer settings"},{"key":"D","text":"The loudspeaker crossover"}]'::jsonb,
  '["A"]'::jsonb,
  'Environmental conditions and incorrect placement can cause false motion events and should be reviewed against device guidance.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician is installing an IP camera on a PoE switch. What should be verified before installation?',
  '[{"key":"A","text":"That the switch port supports the required PoE and network connectivity for the camera"},{"key":"B","text":"That the camera is connected to a speaker output"},{"key":"C","text":"That the lighting dimmer has enough load capacity"},{"key":"D","text":"That the thermostat is in cooling mode"}]'::jsonb,
  '["A"]'::jsonb,
  'IP cameras commonly depend on the network connection for both communication and PoE power, so both must be verified.'
),
(
  14,
  'multiple_choice',
  'application',
  'A security zone is wired but does not appear correctly at the control panel. What should the technician do?',
  '[{"key":"A","text":"Verify the cable, termination, device state, zone assignment, and panel configuration"},{"key":"B","text":"Replace every camera"},{"key":"C","text":"Reprogram the audio system"},{"key":"D","text":"Change the wireless SSID"}]'::jsonb,
  '["A"]'::jsonb,
  'Zone troubleshooting should confirm the complete path from field device through wiring and termination to the configured panel input.'
),
(
  15,
  'multiple_choice',
  'application',
  'A client reports that recorded video is too dark at night. What should be checked?',
  '[{"key":"A","text":"Camera low-light capability, infrared performance, scene lighting, placement, and image settings"},{"key":"B","text":"Speaker cable gauge"},{"key":"C","text":"Lighting keypad labels only"},{"key":"D","text":"The alarm keypad battery only"}]'::jsonb,
  '["A"]'::jsonb,
  'Night image quality depends on camera capability, available or infrared illumination, placement, and appropriate image settings.'
),
(
  16,
  'multiple_choice',
  'application',
  'Before leaving a completed security installation, what should a technician verify?',
  '[{"key":"A","text":"Devices report correctly, cameras show intended views, zones respond properly, labels are accurate, and basic system operation is documented"},{"key":"B","text":"Only that devices have power"},{"key":"C","text":"That all labels have been removed"},{"key":"D","text":"That every device is reset to factory defaults"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic completion includes functional verification, intended coverage, correct zone states, accurate labeling, and documentation.'
),
(
  17,
  'scenario',
  'scenario',
  'A newly installed front-door camera appears online, but the image is pointed too high and does not clearly capture visitors. What is the BEST next step?',
  '[{"key":"A","text":"Re-aim the camera to meet the intended coverage and verify the final view from the monitoring interface"},{"key":"B","text":"Replace the recorder immediately"},{"key":"C","text":"Disable motion recording"},{"key":"D","text":"Move the alarm keypad"}]'::jsonb,
  '["A"]'::jsonb,
  'An online camera is not complete until its field of view meets the intended surveillance objective.'
),
(
  18,
  'scenario',
  'scenario',
  'A window contact works when tested at the panel, but opening the actual window does not change the zone state. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Inspect the field contact alignment, magnet position, wiring, and termination to isolate the physical detection problem"},{"key":"B","text":"Replace the alarm panel first"},{"key":"C","text":"Reboot the network router"},{"key":"D","text":"Adjust the camera frame rate"}]'::jsonb,
  '["A"]'::jsonb,
  'If the panel input can be proven separately, troubleshooting should move to the field device, alignment, and wiring path.'
),
(
  19,
  'scenario',
  'scenario',
  'A camera works when connected directly at the equipment rack but not at its installed location. What is the BEST next step?',
  '[{"key":"A","text":"Compare the known-good connection with the installed cable path, terminations, patching, and PoE delivery"},{"key":"B","text":"Change every camera IP address"},{"key":"C","text":"Replace the alarm siren"},{"key":"D","text":"Disable all recording"}]'::jsonb,
  '["A"]'::jsonb,
  'A known-good rack test helps isolate the issue to the installed cabling, terminations, patching, or power delivery path.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician finishes installing cameras, door contacts, and motion detectors. What is the BEST basic handoff verification?',
  '[{"key":"A","text":"Confirm each device is identified correctly, cameras show intended views, zones change state properly, events are visible to the system, and documentation matches the installation"},{"key":"B","text":"Confirm only that the control panel powers on"},{"key":"C","text":"Delete all device labels"},{"key":"D","text":"Factory-reset the recorder"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete basic handoff verifies device identity, coverage, detection, system visibility, and accurate documentation.'
);


create temporary table _seed_ci_security_surveillance_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_security_surveillance_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of video retention planning in a surveillance system?',
  '[{"key":"A","text":"To determine how long recorded video must remain available based on recording settings, storage capacity, and project requirements"},{"key":"B","text":"To determine speaker impedance"},{"key":"C","text":"To set thermostat schedules"},{"key":"D","text":"To assign lighting scenes"}]'::jsonb,
  '["A"]'::jsonb,
  'Video retention planning aligns storage capacity and recording configuration with the required amount of historical footage.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of camera resolution in a surveillance design?',
  '[{"key":"A","text":"To describe the amount of image detail the camera can capture"},{"key":"B","text":"To determine alarm-zone resistance"},{"key":"C","text":"To assign IP addresses automatically"},{"key":"D","text":"To determine speaker wattage"}]'::jsonb,
  '["A"]'::jsonb,
  'Camera resolution affects the level of visual detail available for monitoring and recorded evidence.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the purpose of an end-of-line resistor in many supervised security circuits?',
  '[{"key":"A","text":"To help the control panel distinguish normal, alarm, and certain wiring-fault conditions"},{"key":"B","text":"To increase camera resolution"},{"key":"C","text":"To provide PoE power"},{"key":"D","text":"To improve wireless bandwidth"}]'::jsonb,
  '["A"]'::jsonb,
  'Supervised circuits use resistance values so the panel can identify normal and abnormal circuit conditions.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why is camera placement affected by lighting conditions?',
  '[{"key":"A","text":"Backlighting, glare, low light, and changing illumination can reduce usable image quality"},{"key":"B","text":"Lighting conditions determine Ethernet cable category"},{"key":"C","text":"Lighting changes alarm-zone numbers"},{"key":"D","text":"Lighting determines recorder storage capacity"}]'::jsonb,
  '["A"]'::jsonb,
  'Scene lighting directly affects whether a camera can produce useful images throughout expected operating conditions.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the purpose of user permissions in a security or surveillance system?',
  '[{"key":"A","text":"To control which users can view, operate, configure, or administer specific system functions"},{"key":"B","text":"To increase detector range"},{"key":"C","text":"To change cable resistance"},{"key":"D","text":"To increase camera frame rate automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'User permissions limit access to system functions according to responsibility and authorization.'
),
(
  6,
  'multiple_choice',
  'application',
  'A camera records clear daytime video but produces unusable images at night. What should be reviewed?',
  '[{"key":"A","text":"Low-light capability, infrared illumination, scene lighting, exposure settings, reflections, and camera placement"},{"key":"B","text":"Only the recorder hostname"},{"key":"C","text":"Only the alarm keypad address"},{"key":"D","text":"Only the camera label"}]'::jsonb,
  '["A"]'::jsonb,
  'Night performance depends on the camera, illumination, exposure behavior, scene conditions, and placement.'
),
(
  7,
  'multiple_choice',
  'application',
  'A surveillance system is not retaining video for the required number of days. What should be checked?',
  '[{"key":"A","text":"Storage capacity, camera count, resolution, frame rate, bitrate, recording schedule, and retention configuration"},{"key":"B","text":"Speaker polarity"},{"key":"C","text":"Lighting keypad programming"},{"key":"D","text":"Thermostat setpoint"}]'::jsonb,
  '["A"]'::jsonb,
  'Retention depends on the amount of video generated, recording behavior, storage capacity, and system configuration.'
),
(
  8,
  'multiple_choice',
  'application',
  'A supervised alarm zone shows a trouble condition rather than normal or alarm. What should the technician review?',
  '[{"key":"A","text":"Field wiring, resistor placement and value, device state, termination, and panel zone configuration"},{"key":"B","text":"Camera focus only"},{"key":"C","text":"Recorder storage only"},{"key":"D","text":"Wireless access-point channels"}]'::jsonb,
  '["A"]'::jsonb,
  'A supervision trouble condition commonly points to wiring, resistance, termination, or configuration outside the expected range.'
),
(
  9,
  'multiple_choice',
  'application',
  'A camera is connected and online but is recording the wrong area after construction changes. What should be done?',
  '[{"key":"A","text":"Re-evaluate the required coverage, adjust placement or field of view, and update documentation to reflect the final condition"},{"key":"B","text":"Change the alarm panel battery"},{"key":"C","text":"Delete the camera from the recorder"},{"key":"D","text":"Disable motion events"}]'::jsonb,
  '["A"]'::jsonb,
  'Coverage must be validated against the current site condition, and documentation should match the final installation.'
),
(
  10,
  'multiple_choice',
  'application',
  'A client can view cameras locally but not through the approved remote-access method. What should be reviewed?',
  '[{"key":"A","text":"Remote-access configuration, user permissions, network reachability, required services, and account or credential status"},{"key":"B","text":"Door-contact alignment"},{"key":"C","text":"Camera mounting height only"},{"key":"D","text":"Alarm siren polarity"}]'::jsonb,
  '["A"]'::jsonb,
  'Remote viewing depends on correct access configuration, authorization, connectivity, and valid account credentials.'
),
(
  11,
  'multiple_choice',
  'application',
  'A motion detector repeatedly activates when no person is present. What is the BEST technical review?',
  '[{"key":"A","text":"Check detector location, environmental sources, sensitivity, coverage pattern, mounting, and manufacturer requirements"},{"key":"B","text":"Replace the video recorder"},{"key":"C","text":"Increase camera bitrate"},{"key":"D","text":"Change every alarm code"}]'::jsonb,
  '["A"]'::jsonb,
  'False motion events should be investigated through placement, environment, configuration, and the detector operating characteristics.'
),
(
  12,
  'multiple_choice',
  'application',
  'A project requires identification-quality video at a gate. What should guide camera selection and placement?',
  '[{"key":"A","text":"Required subject detail, distance, field of view, resolution, lens characteristics, lighting, and mounting position"},{"key":"B","text":"Only the camera housing color"},{"key":"C","text":"Only the number of recorder channels"},{"key":"D","text":"Only the Ethernet switch brand"}]'::jsonb,
  '["A"]'::jsonb,
  'Identification requirements must drive image detail, lens choice, framing, lighting, and physical placement.'
),
(
  13,
  'multiple_choice',
  'application',
  'A technician replaces a failed security control panel. What should be confirmed before returning the system to service?',
  '[{"key":"A","text":"Zone assignments, supervision, device states, user functions, communications, notifications, documentation, and required tests"},{"key":"B","text":"Only that the panel powers on"},{"key":"C","text":"Only that one keypad works"},{"key":"D","text":"Only that the enclosure closes"}]'::jsonb,
  '["A"]'::jsonb,
  'A control-panel replacement requires restoration and validation of the complete system configuration and operational functions.'
),
(
  14,
  'multiple_choice',
  'application',
  'A camera stream is available live but recorded playback frequently skips or has gaps. What should be reviewed?',
  '[{"key":"A","text":"Recording schedule, event settings, storage health, bitrate, network performance, and recorder resource utilization"},{"key":"B","text":"Door-contact magnet spacing"},{"key":"C","text":"Alarm siren placement"},{"key":"D","text":"Lighting fixture wattage"}]'::jsonb,
  '["A"]'::jsonb,
  'Playback gaps can result from recording rules, storage issues, network delivery, or recorder performance limitations.'
),
(
  15,
  'scenario',
  'scenario',
  'A client reports that one exterior camera becomes washed out every afternoon when the sun is behind the subject area. What is the BEST response?',
  '[{"key":"A","text":"Evaluate backlighting, camera orientation, dynamic-range settings, exposure behavior, shading, and whether repositioning is required"},{"key":"B","text":"Replace the alarm panel"},{"key":"C","text":"Increase every camera frame rate"},{"key":"D","text":"Disable recording during the afternoon"}]'::jsonb,
  '["A"]'::jsonb,
  'The symptom is tied to changing scene illumination and should be corrected through camera capability, settings, and placement.'
),
(
  16,
  'scenario',
  'scenario',
  'A security zone intermittently reports trouble after a renovation. The device itself tests correctly at the panel. What is the BEST next step?',
  '[{"key":"A","text":"Inspect the field wiring path, splices, terminations, resistor location, and any construction-related damage or changes"},{"key":"B","text":"Replace the recorder"},{"key":"C","text":"Change all user codes"},{"key":"D","text":"Re-aim every camera"}]'::jsonb,
  '["A"]'::jsonb,
  'If the panel and device function can be proven, intermittent trouble after construction points strongly to the field wiring path or terminations.'
),
(
  17,
  'scenario',
  'scenario',
  'A client needs 30 days of recorded video, but the current system only stores 12 days. What is the BEST approach?',
  '[{"key":"A","text":"Calculate the current recording load and determine whether storage, bitrate, resolution, frame rate, recording mode, or a combination must change to meet the requirement"},{"key":"B","text":"Delete random cameras from the system"},{"key":"C","text":"Disable all event recording"},{"key":"D","text":"Lower every camera setting without calculation"}]'::jsonb,
  '["A"]'::jsonb,
  'Retention changes should be engineered from actual recording demand and the required video-performance standard.'
),
(
  18,
  'scenario',
  'scenario',
  'A newly added IP camera is online and visible from a technician laptop but does not appear in the recorder. What is the BEST troubleshooting sequence?',
  '[{"key":"A","text":"Verify recorder compatibility, camera credentials, addressing, network path, discovery or manual-add settings, licensing if applicable, and recorder configuration"},{"key":"B","text":"Replace the camera cable immediately without testing"},{"key":"C","text":"Reset every camera on the project"},{"key":"D","text":"Disable the security panel"}]'::jsonb,
  '["A"]'::jsonb,
  'Because basic camera connectivity exists, the next focus is recorder integration, compatibility, credentials, network reachability, and configuration.'
),
(
  19,
  'scenario',
  'scenario',
  'A client says several authorized users can view cameras but one employee can see cameras they should not have access to. What is the BEST response?',
  '[{"key":"A","text":"Review that user account, role permissions, camera-group assignments, inherited privileges, and document the corrected access level"},{"key":"B","text":"Change every camera IP address"},{"key":"C","text":"Disable recording"},{"key":"D","text":"Replace the recorder hard drives"}]'::jsonb,
  '["A"]'::jsonb,
  'Access-control problems in the surveillance application should be corrected through account and permission configuration rather than unrelated system changes.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician is preparing a combined intrusion and surveillance system for final handoff. What is the BEST readiness verification?',
  '[{"key":"A","text":"Test zone states and supervision, camera coverage and recording, playback, user permissions, approved remote access, event behavior, labels, and current documentation"},{"key":"B","text":"Confirm only that the alarm can arm"},{"key":"C","text":"Confirm only that live video is visible"},{"key":"D","text":"Factory-reset the system after testing"}]'::jsonb,
  '["A"]'::jsonb,
  'A complete handoff verifies detection, supervision, recording, access, event behavior, documentation, and intended system operation.'
);


create temporary table _seed_ci_security_surveillance_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_security_surveillance_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why should security and surveillance design begin with defined protection and observation objectives?',
  '[{"key":"A","text":"Because device selection, placement, coverage, recording, detection, notification, and access requirements must support specific risks and use cases"},{"key":"B","text":"Because every project should use the same device count"},{"key":"C","text":"Because camera resolution alone determines system performance"},{"key":"D","text":"Because documentation is unnecessary when objectives are clear"}]'::jsonb,
  '["A"]'::jsonb,
  'System design should be driven by the required protection, detection, observation, and operational outcomes.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is event correlation useful in an integrated security system?',
  '[{"key":"A","text":"It can associate related alarms, video, access events, and system activity to improve awareness and investigation"},{"key":"B","text":"It increases cable voltage"},{"key":"C","text":"It replaces all user permissions"},{"key":"D","text":"It eliminates the need for timestamps"}]'::jsonb,
  '["A"]'::jsonb,
  'Correlating related events can provide better context for response, verification, and investigation.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why should surveillance storage be designed as part of the overall system architecture?',
  '[{"key":"A","text":"Retention, camera count, resolution, frame rate, bitrate, redundancy, and failure recovery directly affect storage requirements"},{"key":"B","text":"Storage affects only camera mounting height"},{"key":"C","text":"Every recorder stores unlimited video"},{"key":"D","text":"Storage has no relationship to recording settings"}]'::jsonb,
  '["A"]'::jsonb,
  'Storage architecture must support the recording load, retention requirement, and resilience expected from the system.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'Why are cybersecurity practices important for network-connected security and surveillance systems?',
  '[{"key":"A","text":"Compromised accounts, devices, services, or remote-access methods can expose security functions, video, and client information"},{"key":"B","text":"Cybersecurity is only relevant to audio systems"},{"key":"C","text":"Security devices never communicate over IP networks"},{"key":"D","text":"Factory-default credentials are always appropriate"}]'::jsonb,
  '["A"]'::jsonb,
  'Network-connected security systems require protection of credentials, devices, services, communications, and remote access.'
),
(
  5,
  'multiple_choice',
  'application',
  'A project adds several high-resolution cameras after the recorder and storage were already selected. What should be reviewed?',
  '[{"key":"A","text":"Recorder capacity, supported camera load, incoming bandwidth, storage demand, retention, licensing, and network impact"},{"key":"B","text":"Only the camera housing color"},{"key":"C","text":"Only the alarm keypad model"},{"key":"D","text":"Only the rack-unit position"}]'::jsonb,
  '["A"]'::jsonb,
  'Additional cameras can affect recorder processing, bandwidth, storage, licensing, and required retention.'
),
(
  6,
  'multiple_choice',
  'application',
  'A security system must trigger video verification when a specific intrusion zone alarms. What should be coordinated?',
  '[{"key":"A","text":"Zone identity, event mapping, camera association, timing, recording behavior, notification workflow, and test procedures"},{"key":"B","text":"Only the camera resolution"},{"key":"C","text":"Only the alarm siren volume"},{"key":"D","text":"Only the recorder hostname"}]'::jsonb,
  '["A"]'::jsonb,
  'Integrated event behavior depends on correct mapping between detection, video, recording, notifications, and system timing.'
),
(
  7,
  'multiple_choice',
  'application',
  'A client requires different surveillance access for operators, managers, and administrators. What is the BEST approach?',
  '[{"key":"A","text":"Define role-based permissions using least-privilege access and document which functions and cameras each role requires"},{"key":"B","text":"Give every user administrator rights"},{"key":"C","text":"Use one shared account for all users"},{"key":"D","text":"Disable passwords to simplify support"}]'::jsonb,
  '["A"]'::jsonb,
  'Role-based permissions should provide only the access each user needs while preserving accountability and security.'
),
(
  8,
  'multiple_choice',
  'application',
  'A camera system experiences intermittent recording gaps across multiple cameras connected through the same network path. What should be reviewed?',
  '[{"key":"A","text":"Shared switch and uplink utilization, packet loss, recorder load, storage health, camera bitrate, event configuration, and logs"},{"key":"B","text":"Only one camera lens"},{"key":"C","text":"Only alarm-zone resistance"},{"key":"D","text":"Only user permissions"}]'::jsonb,
  '["A"]'::jsonb,
  'A multi-camera symptom should be investigated through shared infrastructure, recorder resources, storage, and recording configuration.'
),
(
  9,
  'multiple_choice',
  'application',
  'A facility renovation changes walls, entrances, and traffic patterns. What should happen to the security and surveillance design?',
  '[{"key":"A","text":"Reassess detection zones, camera views, device placement, blind spots, wiring paths, and documentation against the new site conditions"},{"key":"B","text":"Leave all devices unchanged automatically"},{"key":"C","text":"Only rename the cameras"},{"key":"D","text":"Only change user passwords"}]'::jsonb,
  '["A"]'::jsonb,
  'Physical changes can alter security risks, coverage, detection, visibility, and infrastructure requirements.'
),
(
  10,
  'multiple_choice',
  'application',
  'A project requires secure remote support for security devices across multiple client sites. What should be defined?',
  '[{"key":"A","text":"Approved remote-access method, authentication, authorization, logging, segmentation, credential handling, and support procedures"},{"key":"B","text":"Open internet access to every device"},{"key":"C","text":"One shared default password"},{"key":"D","text":"Public IP addresses on every camera"}]'::jsonb,
  '["A"]'::jsonb,
  'Remote support should be controlled, authenticated, limited, auditable, and consistent across sites.'
),
(
  11,
  'multiple_choice',
  'application',
  'A replacement recorder supports the same camera count as the original but uses different storage and licensing rules. What should be reviewed before substitution?',
  '[{"key":"A","text":"Camera compatibility, supported features, bandwidth, storage architecture, retention, licensing, integrations, user permissions, and migration requirements"},{"key":"B","text":"Only chassis size"},{"key":"C","text":"Only purchase price"},{"key":"D","text":"Only front-panel appearance"}]'::jsonb,
  '["A"]'::jsonb,
  'Recorder substitution can affect compatibility, retention, integrations, licensing, access, and migration of the existing system.'
),
(
  12,
  'scenario',
  'scenario',
  'A client reports that several cameras freeze at the same time every evening while live viewing and recording are both affected. What is the BEST systems-level response?',
  '[{"key":"A","text":"Correlate the failure time with network utilization, recorder load, storage activity, scheduled tasks, camera bitrate, logs, and other shared dependencies"},{"key":"B","text":"Replace every camera immediately"},{"key":"C","text":"Change all camera passwords"},{"key":"D","text":"Disable recording permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'A simultaneous recurring failure across multiple cameras suggests a shared resource or scheduled condition that should be correlated and measured.'
),
(
  13,
  'scenario',
  'scenario',
  'An intrusion alarm is received from a warehouse door, but the associated camera does not show the doorway because the field of view changed after shelving was installed. What is the BEST response?',
  '[{"key":"A","text":"Reassess the alarm-verification objective, restore appropriate camera coverage, test the event-to-video association, and update documentation"},{"key":"B","text":"Disable the intrusion zone"},{"key":"C","text":"Ignore the camera because the alarm still works"},{"key":"D","text":"Increase recorder retention only"}]'::jsonb,
  '["A"]'::jsonb,
  'The integrated verification workflow is incomplete if the associated video no longer provides the intended view.'
),
(
  14,
  'scenario',
  'scenario',
  'A large facility has repeated false motion alarms in several similar areas during overnight HVAC operation. What is the BEST approach?',
  '[{"key":"A","text":"Analyze event history, environmental patterns, detector type, placement, sensitivity, airflow or temperature effects, and whether design changes are required"},{"key":"B","text":"Disable all motion detectors"},{"key":"C","text":"Replace the video recorder"},{"key":"D","text":"Increase camera frame rates"}]'::jsonb,
  '["A"]'::jsonb,
  'A repeated pattern across similar locations should be investigated as a design or environmental interaction rather than isolated device failures.'
),
(
  15,
  'scenario',
  'scenario',
  'A client discovers that a former employee still has remote access to surveillance video. What is the BEST response?',
  '[{"key":"A","text":"Revoke the account and active sessions, review related credentials and permissions, audit access logs, confirm offboarding procedures, and document the corrective action"},{"key":"B","text":"Change camera mounting positions"},{"key":"C","text":"Delete all recorded video"},{"key":"D","text":"Disable the entire network permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Access should be revoked immediately and the broader identity, credential, audit, and offboarding controls should be reviewed.'
),
(
  16,
  'scenario',
  'scenario',
  'A 64-camera system is meeting live-view requirements but retention has fallen from 30 days to 18 days after image-quality settings were increased. What is the BEST response?',
  '[{"key":"A","text":"Measure the new recording load and redesign bitrate, frame rate, resolution, recording mode, or storage capacity to restore the required retention without compromising required evidence quality"},{"key":"B","text":"Lower every camera to minimum quality without analysis"},{"key":"C","text":"Delete cameras randomly"},{"key":"D","text":"Disable user permissions"}]'::jsonb,
  '["A"]'::jsonb,
  'Retention must be balanced against required image quality using measured recording demand and available storage.'
),
(
  17,
  'scenario',
  'scenario',
  'A security platform integrates intrusion events, cameras, and mobile notifications. Users report that notifications sometimes show the wrong camera. What is the BEST troubleshooting approach?',
  '[{"key":"A","text":"Audit event mappings, zone identifiers, camera associations, rules, naming conventions, timestamps, and recent configuration changes"},{"key":"B","text":"Replace every camera"},{"key":"C","text":"Increase storage capacity"},{"key":"D","text":"Disable all notifications"}]'::jsonb,
  '["A"]'::jsonb,
  'Incorrect event context usually requires tracing the mapping and naming logic between detection events and associated video or notification rules.'
),
(
  18,
  'scenario',
  'scenario',
  'A client wants to migrate an operating surveillance system to a new recorder platform with minimal downtime. What is the BEST preparation?',
  '[{"key":"A","text":"Document cameras, addressing, credentials, licenses, recording settings, retention, user permissions, integrations, storage needs, backups, migration sequence, and rollback plan"},{"key":"B","text":"Disconnect the old recorder before documenting anything"},{"key":"C","text":"Factory-reset all cameras first"},{"key":"D","text":"Assume the new recorder will import every setting automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'A controlled migration requires an inventory of the existing system, compatibility and capacity planning, configuration preservation, and a rollback path.'
),
(
  19,
  'scenario',
  'scenario',
  'A multi-building site uses intrusion detection and surveillance across several network segments. One building loses both camera connectivity and alarm communications intermittently. What is the BEST systems-level response?',
  '[{"key":"A","text":"Identify shared infrastructure for that building and review network links, power, switches, gateways, communication paths, logs, environmental conditions, and failure timing"},{"key":"B","text":"Replace every field device in the building"},{"key":"C","text":"Change all user codes"},{"key":"D","text":"Disable event recording"}]'::jsonb,
  '["A"]'::jsonb,
  'When multiple subsystems fail together in one location, troubleshooting should focus first on shared infrastructure and common dependencies.'
),
(
  20,
  'scenario',
  'scenario',
  'A complex security project is ready for handoff and includes intrusion detection, supervised zones, IP cameras, recording, event-driven video, remote access, multiple user roles, and notifications. What is the BEST final technical review?',
  '[{"key":"A","text":"Verify detection and supervision, camera coverage, recording and retention, playback, event correlation, notifications, permissions, remote access, cybersecurity settings, backups, labels, documentation, and end-to-end workflows"},{"key":"B","text":"Confirm only that every device powers on"},{"key":"C","text":"Confirm only that live video is available"},{"key":"D","text":"Remove configuration backups after testing"}]'::jsonb,
  '["A"]'::jsonb,
  'A complex security system requires end-to-end validation of detection, surveillance, storage, integrations, access, security, and documentation.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '21b2adb9-1b5c-425f-b655-3af1fdde7799';
  v_l1_role_id uuid := '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f';
  v_l2_role_id uuid := '925c6250-5991-4179-afed-e47fa6a08a31';
  v_l3_role_id uuid := 'cefefd09-9d5b-4a67-87a9-830180b5a016';
  v_assessment_id uuid;
  v_master_question_id uuid;
  v_assessment_question_id uuid;
  v_row record;
  v_level integer;
  v_role_template_id uuid;
  v_assessment_name text;
begin
  select i.id into v_industry_id
  from public.industries i
  where lower(i.slug) = 'custom-integration'
     or lower(i.name) = 'custom integration'
  order by case when lower(i.slug) = 'custom-integration' then 0 else 1 end
  limit 1;

  if v_industry_id is null then
    raise exception 'Custom Integration industry not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_templates c
    where c.id = v_competency_id
      and c.industry_id = v_industry_id
      and c.name = 'Security / Surveillance'
      and c.is_current = true
  ) then
    raise exception 'Current Security / Surveillance Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l1_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician I — Entry Level'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 1
  ) then
    raise exception 'Current Technician I — Entry Level L1 Security / Surveillance requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l2_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician II — Experienced'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Technician II — Experienced L2 Security / Surveillance requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l3_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician III — Lead Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Technician III — Lead Technician L3 Security / Surveillance requirement not found';
  end if;


  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 1
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 8
      and s.application_count = 8
      and s.scenario_count = 4
  ) then
    raise exception 'Expected current L1 assessment standard 20 / 8 / 8 / 4 not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 2
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 5
      and s.application_count = 9
      and s.scenario_count = 6
  ) then
    raise exception 'Expected current L2 assessment standard 20 / 5 / 9 / 6 not found';
  end if;

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 3
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 4
      and s.application_count = 7
      and s.scenario_count = 9
  ) then
    raise exception 'Expected current L3 assessment standard 20 / 4 / 7 / 9 not found';
  end if;


  -- ========================================================================
  -- Seed Level 1
  -- ========================================================================

  v_level := 1;
  v_role_template_id := v_l1_role_id;
  v_assessment_name := 'Security / Surveillance — Level 1 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_ci_security_surveillance_l1_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
    limit 1;

    if v_master_question_id is null then
      insert into public.master_question_bank (
        industry_id,
        master_competency_template_id,
        domain,
        type,
        difficulty,
        prompt,
        options,
        points,
        critical_safety,
        practical_verification_required,
        status,
        version,
        is_current
      )
      values (
        v_industry_id,
        v_competency_id,
        'Security / Surveillance',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        false,
        false,
        'approved',
        1,
        true
      )
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Security / Surveillance L1 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

    insert into public.master_question_role_applicability (
      master_question_id,
      master_role_template_id
    )
    values (
      v_master_question_id,
      v_l1_role_id
    )
    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
    limit 1;

    if v_assessment_question_id is null then
      insert into public.assessment_questions (
        assessment_id,
        master_competency_template_id,
        type,
        prompt,
        scenario,
        image_url,
        options,
        points,
        sort_order,
        source_master_question_id,
        domain,
        difficulty,
        critical_safety,
        practical_verification_required
      )
      values (
        v_assessment_id,
        v_competency_id,
        v_row.question_type,
        v_row.prompt,
        null,
        null,
        v_row.options,
        1,
        v_row.question_number,
        v_master_question_id,
        'Security / Surveillance',
        v_row.difficulty,
        false,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Security / Surveillance L1 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 2
  -- ========================================================================

  v_level := 2;
  v_role_template_id := v_l2_role_id;
  v_assessment_name := 'Security / Surveillance — Level 2 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_ci_security_surveillance_l2_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
    limit 1;

    if v_master_question_id is null then
      insert into public.master_question_bank (
        industry_id,
        master_competency_template_id,
        domain,
        type,
        difficulty,
        prompt,
        options,
        points,
        critical_safety,
        practical_verification_required,
        status,
        version,
        is_current
      )
      values (
        v_industry_id,
        v_competency_id,
        'Security / Surveillance',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        false,
        false,
        'approved',
        1,
        true
      )
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Security / Surveillance L2 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

    insert into public.master_question_role_applicability (
      master_question_id,
      master_role_template_id
    )
    values (
      v_master_question_id,
      v_l2_role_id
    )
    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
    limit 1;

    if v_assessment_question_id is null then
      insert into public.assessment_questions (
        assessment_id,
        master_competency_template_id,
        type,
        prompt,
        scenario,
        image_url,
        options,
        points,
        sort_order,
        source_master_question_id,
        domain,
        difficulty,
        critical_safety,
        practical_verification_required
      )
      values (
        v_assessment_id,
        v_competency_id,
        v_row.question_type,
        v_row.prompt,
        null,
        null,
        v_row.options,
        1,
        v_row.question_number,
        v_master_question_id,
        'Security / Surveillance',
        v_row.difficulty,
        false,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Security / Surveillance L2 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 3
  -- ========================================================================

  v_level := 3;
  v_role_template_id := v_l3_role_id;
  v_assessment_name := 'Security / Surveillance — Level 3 Competency Assessment';

  select a.id
  into v_assessment_id
  from public.assessments a
  where a.client_id is null
    and a.industry_id = v_industry_id
    and a.type = 'competency'
    and a.master_competency_template_id = v_competency_id
    and a.target_level = v_level
    and a.is_current = true
  order by a.version desc, a.name, a.id
  limit 1;

  if v_assessment_id is null then
    insert into public.assessments (
      client_id, industry_id, name, type,
      master_competency_template_id, target_level,
      version, is_current
    )
    values (
      null, v_industry_id, v_assessment_name, 'competency',
      v_competency_id, v_level,
      1, true
    )
    returning id into v_assessment_id;
  end if;

  for v_row in
    select * from _seed_ci_security_surveillance_l3_questions
    order by question_number
  loop
    select q.id
    into v_master_question_id
    from public.master_question_bank q
    where q.industry_id = v_industry_id
      and q.master_competency_template_id = v_competency_id
      and q.prompt = v_row.prompt
      and q.is_current = true
    order by q.version desc, q.id
    limit 1;

    if v_master_question_id is null then
      insert into public.master_question_bank (
        industry_id,
        master_competency_template_id,
        domain,
        type,
        difficulty,
        prompt,
        options,
        points,
        critical_safety,
        practical_verification_required,
        status,
        version,
        is_current
      )
      values (
        v_industry_id,
        v_competency_id,
        'Security / Surveillance',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        false,
        false,
        'approved',
        1,
        true
      )
      returning id into v_master_question_id;
    end if;

    insert into public.master_question_answer_keys (
      master_question_id,
      correct_answer,
      scoring_notes,
      rationale
    )
    select
      v_master_question_id,
      v_row.correct_answer,
      'IntegrateU Security / Surveillance L3 production assessment v1.0.',
      v_row.rationale
    where not exists (
      select 1
      from public.master_question_answer_keys k
      where k.master_question_id = v_master_question_id
    );

    insert into public.master_question_role_applicability (
      master_question_id,
      master_role_template_id
    )
    values (
      v_master_question_id,
      v_role_template_id
    )
    on conflict (
      master_question_id,
      master_role_template_id
    )
    do nothing;

    select aq.id
    into v_assessment_question_id
    from public.assessment_questions aq
    where aq.assessment_id = v_assessment_id
      and aq.source_master_question_id = v_master_question_id
    limit 1;

    if v_assessment_question_id is null then
      insert into public.assessment_questions (
        assessment_id,
        master_competency_template_id,
        type,
        prompt,
        scenario,
        image_url,
        options,
        points,
        sort_order,
        source_master_question_id,
        domain,
        difficulty,
        critical_safety,
        practical_verification_required
      )
      values (
        v_assessment_id,
        v_competency_id,
        v_row.question_type,
        v_row.prompt,
        null,
        null,
        v_row.options,
        1,
        v_row.question_number,
        v_master_question_id,
        'Security / Surveillance',
        v_row.difficulty,
        false,
        false
      )
      returning id into v_assessment_question_id;
    end if;

    insert into public.assessment_question_answer_keys (
      question_id,
      correct_answer,
      scoring_notes
    )
    select
      v_assessment_question_id,
      v_row.correct_answer,
      concat_ws(
        E'\\n\\n',
        'IntegrateU Security / Surveillance L3 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================

end;
$$;

commit;

-- ============================================================================
-- VERIFICATION 1 — EXACT PER-LEVEL PRODUCTION COUNTS
-- Expected:
--   Level 1 -> 20 / 20 / 8 / 8 / 4
--   Level 2 -> 20 / 20 / 5 / 9 / 6
--   Level 3 -> 20 / 20 / 4 / 7 / 9
-- ============================================================================

select
  a.target_level,
  a.id as assessment_id,
  a.name as assessment_name,
  count(distinct aq.id)::integer as question_count,
  count(distinct ak.question_id)::integer as answer_key_count,
  count(distinct aq.id) filter (where aq.difficulty = 'foundational')::integer as foundational_count,
  count(distinct aq.id) filter (where aq.difficulty = 'application')::integer as application_count,
  count(distinct aq.id) filter (where aq.difficulty = 'scenario')::integer as scenario_count
from public.assessments a
left join public.assessment_questions aq
  on aq.assessment_id = a.id
 and aq.master_competency_template_id =
   '21b2adb9-1b5c-425f-b655-3af1fdde7799'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '21b2adb9-1b5c-425f-b655-3af1fdde7799'::uuid
  and a.target_level in (1,2,3)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 Installer / Helper      -> 20
--   Level 2 Design & Sales Engineer -> 20
--   Level 3 Service & Repair        -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '21b2adb9-1b5c-425f-b655-3af1fdde7799'::uuid
    and a.target_level in (1,2,3)
    and aq.master_competency_template_id =
      '21b2adb9-1b5c-425f-b655-3af1fdde7799'::uuid
    and aq.source_master_question_id is not null
)
select
  q.target_level,
  count(distinct ra.master_question_id)::integer as role_applicability_count
from q
join public.master_question_role_applicability ra
  on ra.master_question_id = q.source_master_question_id
where
  (q.target_level = 1 and ra.master_role_template_id =
    '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f'::uuid)
  or
  (q.target_level = 2 and ra.master_role_template_id =
    '925c6250-5991-4179-afed-e47fa6a08a31'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    'cefefd09-9d5b-4a67-87a9-830180b5a016'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '21b2adb9-1b5c-425f-b655-3af1fdde7799'::uuid;

-- ============================================================================
-- VERIFICATION 4 — NO DUPLICATE CURRENT ASSESSMENTS PER TARGET LEVEL
-- Expected: zero rows
-- ============================================================================

select
  a.target_level,
  count(*) as current_assessment_count
from public.assessments a
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '21b2adb9-1b5c-425f-b655-3af1fdde7799'::uuid
  and a.target_level in (1,2,3)
group by a.target_level
having count(*) > 1;
