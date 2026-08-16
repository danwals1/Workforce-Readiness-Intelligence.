-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0159_ci_av_systems_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: AV Systems
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Technician I — Entry Level                 -> Level 1
--   Logistics Manager                    -> Level 2
--   Technician II — Experienced                 -> Level 3
--   Technician III — Lead Technician                   -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess audio/video system fundamentals,
-- signal flow, source-to-display and source-to-speaker paths, installation,
-- configuration, testing, integration, and progressively higher AV systems judgment.
-- ============================================================================

begin;

create temporary table _seed_ci_av_systems_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_av_systems_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of an audio/video source device?',
  '[{"key":"A","text":"To provide the audio or video content that will be processed, distributed, or presented"},{"key":"B","text":"To amplify every loudspeaker directly"},{"key":"C","text":"To terminate network cabling"},{"key":"D","text":"To provide electrical grounding for the system"}]'::jsonb,
  '["A"]'::jsonb,
  'A source originates the content that moves through the AV system.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does signal flow describe in an AV system?',
  '[{"key":"A","text":"The path audio or video takes from its source through system devices to its destination"},{"key":"B","text":"The order equipment was purchased"},{"key":"C","text":"The physical location of every power outlet"},{"key":"D","text":"The sequence technicians arrive on site"}]'::jsonb,
  '["A"]'::jsonb,
  'Signal flow identifies how content moves through sources, processing, distribution, and output devices.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the primary role of a display in a video system?',
  '[{"key":"A","text":"To present the video signal as a visible image"},{"key":"B","text":"To generate the original source content"},{"key":"C","text":"To amplify loudspeaker signals"},{"key":"D","text":"To distribute network addresses"}]'::jsonb,
  '["A"]'::jsonb,
  'A display is an endpoint that presents video content to the viewer.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the primary role of a loudspeaker in an audio system?',
  '[{"key":"A","text":"To convert an electrical audio signal into sound"},{"key":"B","text":"To create the original music source"},{"key":"C","text":"To route video between displays"},{"key":"D","text":"To configure network devices"}]'::jsonb,
  '["A"]'::jsonb,
  'A loudspeaker converts the electrical audio signal into acoustic output.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the purpose of an audio amplifier?',
  '[{"key":"A","text":"To provide the power needed to drive compatible loudspeakers"},{"key":"B","text":"To create video resolution"},{"key":"C","text":"To terminate category cable"},{"key":"D","text":"To store source content"}]'::jsonb,
  '["A"]'::jsonb,
  'An amplifier increases an audio signal to a level suitable for driving loudspeakers.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is an AV input?',
  '[{"key":"A","text":"A connection or signal path where audio or video enters a device"},{"key":"B","text":"A connection used only for electrical power"},{"key":"C","text":"The final destination of every signal"},{"key":"D","text":"A label used only for loudspeaker wiring"}]'::jsonb,
  '["A"]'::jsonb,
  'Inputs receive signals from upstream devices in the AV signal path.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What is an AV output?',
  '[{"key":"A","text":"A connection or signal path where audio or video leaves a device for the next destination"},{"key":"B","text":"A connection used only for incoming power"},{"key":"C","text":"The source-selection menu on a display"},{"key":"D","text":"A method for mounting equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Outputs send signals downstream to another device or final endpoint.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'Why is equipment labeling important in an AV installation?',
  '[{"key":"A","text":"It helps technicians identify devices, cables, sources, destinations, and signal paths consistently"},{"key":"B","text":"It increases signal strength"},{"key":"C","text":"It replaces system drawings"},{"key":"D","text":"It automatically configures equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Clear labeling supports installation, service, documentation, and accurate signal-path identification.'
),
(
  9,
  'multiple_choice',
  'application',
  'A television is connected to three source devices. What should the technician confirm before testing a specific source?',
  '[{"key":"A","text":"That the display is selected to the input connected to that source"},{"key":"B","text":"That every other source is disconnected permanently"},{"key":"C","text":"That the loudspeaker wiring has been removed"},{"key":"D","text":"That the network router has been replaced"}]'::jsonb,
  '["A"]'::jsonb,
  'The display must be selected to the correct input for the intended video source.'
),
(
  10,
  'multiple_choice',
  'application',
  'A source device has one video output connected to a distribution device that feeds several displays. Which description BEST matches the signal flow?',
  '[{"key":"A","text":"Source to distribution device to displays"},{"key":"B","text":"Displays to source to distribution device"},{"key":"C","text":"Distribution device to source to power outlet"},{"key":"D","text":"Displays directly to each other"}]'::jsonb,
  '["A"]'::jsonb,
  'The source feeds the distribution stage, which then routes the signal to the displays.'
),
(
  11,
  'multiple_choice',
  'application',
  'A stereo amplifier has left and right loudspeaker outputs. What is the BEST installation practice?',
  '[{"key":"A","text":"Connect each loudspeaker to the intended channel while maintaining correct conductor identification and polarity"},{"key":"B","text":"Join all loudspeaker conductors together regardless of channel"},{"key":"C","text":"Connect loudspeaker outputs to video inputs"},{"key":"D","text":"Ignore channel labeling because both outputs are identical"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct channel assignment and polarity help preserve intended audio reproduction and system documentation.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician is installing an AV rack. Why should source, processing, distribution, amplification, and destination connections be matched to the system drawing?',
  '[{"key":"A","text":"To ensure the physical installation follows the intended signal flow and device relationships"},{"key":"B","text":"To make every device use the same input number"},{"key":"C","text":"To eliminate the need for cable labels"},{"key":"D","text":"To increase amplifier power"}]'::jsonb,
  '["A"]'::jsonb,
  'The system drawing communicates the intended device connections and signal paths.'
),
(
  13,
  'multiple_choice',
  'application',
  'A source provides both audio and video to a downstream AV device. What should the technician verify when making the connection?',
  '[{"key":"A","text":"That the selected connection and device inputs support the required audio and video signal path"},{"key":"B","text":"That only the video portion is documented"},{"key":"C","text":"That every output on the device is used"},{"key":"D","text":"That loudspeakers are connected directly to the source regardless of system design"}]'::jsonb,
  '["A"]'::jsonb,
  'The connection method must support the signals required by the designed AV path.'
),
(
  14,
  'multiple_choice',
  'application',
  'A rack drawing identifies a device output as feeding Display 2. What should the field technician do?',
  '[{"key":"A","text":"Connect and label that output according to the drawing unless an approved change says otherwise"},{"key":"B","text":"Choose any available display connection"},{"key":"C","text":"Ignore the drawing and use the shortest cable"},{"key":"D","text":"Connect the output to an amplifier instead"}]'::jsonb,
  '["A"]'::jsonb,
  'Following documented signal assignments preserves design intent and makes the system easier to support.'
),
(
  15,
  'multiple_choice',
  'application',
  'An AV processor has several labeled inputs and outputs. What is the BEST way to connect it during installation?',
  '[{"key":"A","text":"Use the system documentation to match each source and destination to the intended input and output"},{"key":"B","text":"Connect devices randomly and rename them later"},{"key":"C","text":"Use only the first available port for every connection"},{"key":"D","text":"Connect outputs to outputs whenever possible"}]'::jsonb,
  '["A"]'::jsonb,
  'Input and output assignments should match the designed signal flow and documentation.'
),
(
  16,
  'multiple_choice',
  'application',
  'A technician is preparing to mount a display. Which AV-related information is MOST important to confirm before final connection?',
  '[{"key":"A","text":"The intended source path, input connection, required cabling, and any associated audio or control connections"},{"key":"B","text":"Only the display packaging color"},{"key":"C","text":"Only the room paint color"},{"key":"D","text":"Only the warehouse shelf where the display was stored"}]'::jsonb,
  '["A"]'::jsonb,
  'The installer should understand how the display fits into the complete AV signal and control path before final connection.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician is installing a simple system with a streaming source, an AV receiver, a television, and two loudspeakers. Which signal flow is MOST appropriate?',
  '[{"key":"A","text":"Streaming source to AV receiver, receiver video output to television, and receiver speaker outputs to loudspeakers"},{"key":"B","text":"Television to streaming source to loudspeakers to receiver"},{"key":"C","text":"Loudspeakers to television to receiver to source"},{"key":"D","text":"Receiver speaker outputs directly to the streaming source"}]'::jsonb,
  '["A"]'::jsonb,
  'The source feeds the receiver, which routes video to the display and amplified audio to the loudspeakers.'
),
(
  18,
  'scenario',
  'scenario',
  'A system drawing shows one media source feeding a distribution device that serves four displays. A technician connects one display directly to the source and bypasses the distribution device. What is the BEST correction?',
  '[{"key":"A","text":"Reconnect the display through the intended distribution path and label the connection according to the drawing"},{"key":"B","text":"Leave it because any working connection is acceptable"},{"key":"C","text":"Disconnect the other three displays"},{"key":"D","text":"Connect the display to a loudspeaker output"}]'::jsonb,
  '["A"]'::jsonb,
  'The physical installation should follow the designed distribution architecture unless a change is formally approved.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician finds several unlabeled AV cables at a rack location during installation. What is the BEST response?',
  '[{"key":"A","text":"Identify each cable using the drawings, cable records, endpoints, or approved test methods, then label it before final connection"},{"key":"B","text":"Connect each cable to the nearest open port"},{"key":"C","text":"Discard the cables and install new ones immediately"},{"key":"D","text":"Leave them unlabeled after connecting them"}]'::jsonb,
  '["A"]'::jsonb,
  'AV signal paths should be positively identified before connection so the finished system matches the design and remains serviceable.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician completes a basic AV installation containing one source, one display, and an external audio system. Before handing the work off, what is the BEST check?',
  '[{"key":"A","text":"Confirm the source follows the intended signal path to the display and audio system, connections are secure, and labels match the documentation"},{"key":"B","text":"Confirm only that all equipment has power"},{"key":"C","text":"Remove the cable labels because installation is complete"},{"key":"D","text":"Change the documented signal path to match any accidental field connections"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic installation quality includes correct signal flow, secure connections, and alignment between field work and documentation.'
);

create temporary table _seed_ci_av_systems_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_av_systems_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the purpose of an AV distribution device?',
  '[{"key":"A","text":"To route or distribute one or more audio/video signals to intended destinations"},{"key":"B","text":"To power every loudspeaker directly"},{"key":"C","text":"To replace all source devices"},{"key":"D","text":"To configure internet service"}]'::jsonb,
  '["A"]'::jsonb,
  'Distribution devices route AV signals from sources or processors to one or more destinations.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of AV signal processing?',
  '[{"key":"A","text":"To modify, convert, manage, or condition audio/video signals for the required system operation"},{"key":"B","text":"To replace physical cabling"},{"key":"C","text":"To provide building power"},{"key":"D","text":"To store only equipment serial numbers"}]'::jsonb,
  '["A"]'::jsonb,
  'Signal processing prepares or manages AV signals so they work correctly within the designed system.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why must source, processor, distribution, and destination devices be signal-compatible?',
  '[{"key":"A","text":"The connected devices must support the required signal format and path for reliable operation"},{"key":"B","text":"Compatible devices always use the same manufacturer"},{"key":"C","text":"Compatibility matters only for loudspeakers"},{"key":"D","text":"Signal compatibility is unnecessary when equipment has power"}]'::jsonb,
  '["A"]'::jsonb,
  'AV devices must support the signal types and formats used along the designed path.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of gain structure in an audio system?',
  '[{"key":"A","text":"To manage signal levels through the audio path so the system operates with appropriate headroom and noise performance"},{"key":"B","text":"To increase every volume control to maximum"},{"key":"C","text":"To select video resolution"},{"key":"D","text":"To assign network addresses"}]'::jsonb,
  '["A"]'::jsonb,
  'Gain structure manages audio levels across sources, processing, amplification, and outputs.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Why is aspect ratio important in a video system?',
  '[{"key":"A","text":"It describes the proportional relationship between image width and height and affects how content is displayed"},{"key":"B","text":"It determines loudspeaker impedance"},{"key":"C","text":"It defines amplifier output power"},{"key":"D","text":"It controls network bandwidth"}]'::jsonb,
  '["A"]'::jsonb,
  'Aspect ratio affects how video content fits and appears on a display.'
),
(
  6,
  'multiple_choice',
  'application',
  'A source feeds a matrix switcher that serves four displays. What should the technician verify when adding a fifth display?',
  '[{"key":"A","text":"That an appropriate output path exists and that the distribution system, signal format, cabling, and destination support the added display"},{"key":"B","text":"That every existing display is disconnected first"},{"key":"C","text":"That amplifier gain is increased"},{"key":"D","text":"That the source is replaced"}]'::jsonb,
  '["A"]'::jsonb,
  'Adding a destination requires confirming available routing capacity and compatibility across the new signal path.'
),
(
  7,
  'multiple_choice',
  'application',
  'A source outputs a video format that a connected display does not support. What is the BEST system-level correction?',
  '[{"key":"A","text":"Configure the source or processing path to provide a format supported by the display"},{"key":"B","text":"Increase speaker volume"},{"key":"C","text":"Reverse the signal direction"},{"key":"D","text":"Disconnect all other sources"}]'::jsonb,
  '["A"]'::jsonb,
  'The signal format reaching the destination must be compatible with that destination.'
),
(
  8,
  'multiple_choice',
  'application',
  'An audio processor feeds multiple amplifier channels. What should the technician verify before finalizing the configuration?',
  '[{"key":"A","text":"That each processor output is routed to the intended amplifier channel and loudspeaker zone with appropriate signal levels"},{"key":"B","text":"That every amplifier channel receives the same source"},{"key":"C","text":"That video outputs are connected to speaker terminals"},{"key":"D","text":"That all zones use maximum gain"}]'::jsonb,
  '["A"]'::jsonb,
  'Audio routing and level assignments should match the intended zones and system design.'
),
(
  9,
  'multiple_choice',
  'application',
  'A display receives video but no audio from an AV receiver. What should the technician confirm first?',
  '[{"key":"A","text":"Whether the system design intends audio to play through the display or through separate loudspeakers and whether the receiver routing matches that design"},{"key":"B","text":"Whether the display mount is level"},{"key":"C","text":"Whether the source has internet access"},{"key":"D","text":"Whether the rack has spare outlets"}]'::jsonb,
  '["A"]'::jsonb,
  'Audio behavior should be evaluated against the intended signal path before changes are made.'
),
(
  10,
  'multiple_choice',
  'application',
  'A source must be available on two displays at the same time. Which system function is required?',
  '[{"key":"A","text":"A distribution or routing path capable of feeding the source to both destinations"},{"key":"B","text":"A larger loudspeaker"},{"key":"C","text":"A second electrical service"},{"key":"D","text":"A different wall mount"}]'::jsonb,
  '["A"]'::jsonb,
  'Simultaneous presentation on multiple displays requires the source signal to be distributed to each destination.'
),
(
  11,
  'multiple_choice',
  'application',
  'A technician is configuring an AV receiver with several sources. What is the BEST practice for input naming?',
  '[{"key":"A","text":"Use clear names that match the actual connected sources and system documentation"},{"key":"B","text":"Leave every input with a generic factory name"},{"key":"C","text":"Name inputs according to cable color only"},{"key":"D","text":"Use different names on the receiver and documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent source naming improves usability, documentation, and serviceability.'
),
(
  12,
  'multiple_choice',
  'application',
  'A two-channel amplifier is being connected to two loudspeakers. What should the technician verify?',
  '[{"key":"A","text":"Correct channel assignment, polarity, supported load, and secure terminations"},{"key":"B","text":"That both loudspeakers are connected to one output regardless of design"},{"key":"C","text":"That video resolution matches amplifier power"},{"key":"D","text":"That all speaker conductors are tied together"}]'::jsonb,
  '["A"]'::jsonb,
  'Amplifier-to-loudspeaker connections should follow channel, polarity, load, and termination requirements.'
),
(
  13,
  'multiple_choice',
  'application',
  'A video extender system uses a transmitter at the source end and a receiver at the display end. What is the BEST installation approach?',
  '[{"key":"A","text":"Connect the transmitter and receiver in the intended signal direction using the specified interconnect and endpoint connections"},{"key":"B","text":"Reverse the transmitter and receiver because they are interchangeable"},{"key":"C","text":"Connect both units directly to loudspeakers"},{"key":"D","text":"Ignore device labeling if the connectors fit"}]'::jsonb,
  '["A"]'::jsonb,
  'Extender components have defined source-side and destination-side functions and should be installed in the intended direction.'
),
(
  14,
  'multiple_choice',
  'application',
  'An AV rack contains sources, a matrix, an audio processor, amplifiers, and networked control equipment. What is the BEST way to verify the installation before programming?',
  '[{"key":"A","text":"Compare actual connections, labels, power, and signal paths against the approved rack and system documentation"},{"key":"B","text":"Assume the rack is correct if every device powers on"},{"key":"C","text":"Begin changing configuration before checking wiring"},{"key":"D","text":"Remove all labels to simplify the rack"}]'::jsonb,
  '["A"]'::jsonb,
  'Physical installation should be verified against design documentation before configuration work begins.'
),
(
  15,
  'scenario',
  'scenario',
  'A conference room has a table source, a matrix switcher, two displays, an audio processor, an amplifier, and ceiling loudspeakers. The client wants the table source on both displays with audio through the ceiling speakers. Which signal flow BEST matches the request?',
  '[{"key":"A","text":"Table source to matrix for video distribution, with audio routed through the processor and amplifier to the ceiling loudspeakers"},{"key":"B","text":"Ceiling loudspeakers to amplifier to table source to displays"},{"key":"C","text":"Displays to matrix to table source, with no audio path"},{"key":"D","text":"Amplifier directly to both displays for video distribution"}]'::jsonb,
  '["A"]'::jsonb,
  'The requested experience requires video distribution to both displays and a separate routed audio path to the amplified loudspeaker system.'
),
(
  16,
  'scenario',
  'scenario',
  'A media room source works on one display but not on a second display connected through the same matrix. The system drawing shows the second display should be on Output 4, but the cable is connected to Output 3. What is the BEST correction?',
  '[{"key":"A","text":"Move the connection to the documented output or formally update the routing and documentation if the design has changed"},{"key":"B","text":"Replace the source"},{"key":"C","text":"Increase amplifier power"},{"key":"D","text":"Leave the mismatch undocumented"}]'::jsonb,
  '["A"]'::jsonb,
  'Physical routing should match the documented design unless a controlled change is made.'
),
(
  17,
  'scenario',
  'scenario',
  'A multi-zone audio system has the correct source selected, but one zone is much louder than the others at the same user volume setting. What is the BEST response?',
  '[{"key":"A","text":"Review the audio routing, processor output level, amplifier gain, and zone configuration for that path rather than changing unrelated zones"},{"key":"B","text":"Replace all loudspeakers"},{"key":"C","text":"Increase every amplifier channel to maximum"},{"key":"D","text":"Change the video source"}]'::jsonb,
  '["A"]'::jsonb,
  'Uneven zone level can result from differences in configured gain or routing along that audio path.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician installs a new source into an existing AV system. The source appears on the local rack monitor but not on any room displays. What is the BEST next step?',
  '[{"key":"A","text":"Verify that the source is assigned to the intended matrix or distribution input and that routing to room outputs is configured correctly"},{"key":"B","text":"Replace every room display"},{"key":"C","text":"Reconnect all loudspeakers"},{"key":"D","text":"Change the rack power sequence"}]'::jsonb,
  '["A"]'::jsonb,
  'Local source operation confirms the source is producing output; the next concern is its assignment and distribution through the AV system.'
),
(
  19,
  'scenario',
  'scenario',
  'A display shows an image, but the picture is stretched and people appear unnaturally wide. What is the BEST correction?',
  '[{"key":"A","text":"Review source and display resolution or aspect-ratio settings so the image is presented in the intended proportions"},{"key":"B","text":"Increase amplifier gain"},{"key":"C","text":"Replace the loudspeakers"},{"key":"D","text":"Reverse the video cable direction"}]'::jsonb,
  '["A"]'::jsonb,
  'Incorrect scaling or aspect settings can distort an otherwise valid video signal.'
),
(
  20,
  'scenario',
  'scenario',
  'A technician completes a multi-source AV rack and is preparing for handoff to programming. What is the BEST readiness check?',
  '[{"key":"A","text":"Verify source-to-destination signal paths, labels, physical connections, basic audio/video operation, and alignment with the approved documentation"},{"key":"B","text":"Confirm only that every device has power"},{"key":"C","text":"Skip signal verification because programming will reveal all installation problems"},{"key":"D","text":"Remove documentation after installation"}]'::jsonb,
  '["A"]'::jsonb,
  'A properly prepared AV system should have verified physical paths and basic function before higher-level configuration or programming.'
);

create temporary table _seed_ci_av_systems_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_av_systems_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Why is end-to-end signal-path planning important in a larger AV system?',
  '[{"key":"A","text":"Every source, processor, distribution stage, transport method, and destination must work together as one compatible path"},{"key":"B","text":"It allows devices to be connected without documentation"},{"key":"C","text":"It eliminates the need to consider signal formats"},{"key":"D","text":"It guarantees every device can use factory defaults"}]'::jsonb,
  '["A"]'::jsonb,
  'An AV system performs as a complete chain, so compatibility and design decisions must be evaluated across the entire signal path.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is the purpose of EDID in a digital video system?',
  '[{"key":"A","text":"To communicate display capabilities so upstream devices can select compatible video and audio formats"},{"key":"B","text":"To provide loudspeaker amplification"},{"key":"C","text":"To assign network addresses"},{"key":"D","text":"To control rack temperature"}]'::jsonb,
  '["A"]'::jsonb,
  'EDID communicates destination capabilities such as supported resolutions and audio formats to upstream devices.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is bandwidth planning important in digital AV distribution?',
  '[{"key":"A","text":"The transport and distribution path must support the required data rate of the intended audio/video formats"},{"key":"B","text":"Higher bandwidth always improves loudspeaker impedance"},{"key":"C","text":"Bandwidth affects only equipment labels"},{"key":"D","text":"Bandwidth is irrelevant when video is digital"}]'::jsonb,
  '["A"]'::jsonb,
  'Digital AV formats require sufficient transport capacity throughout the signal path.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the purpose of audio DSP in an integrated AV system?',
  '[{"key":"A","text":"To route, mix, filter, delay, equalize, and otherwise process audio signals for the intended system behavior"},{"key":"B","text":"To generate video images"},{"key":"C","text":"To replace loudspeaker amplification"},{"key":"D","text":"To provide AC power conditioning"}]'::jsonb,
  '["A"]'::jsonb,
  'Digital signal processing provides controlled audio routing and processing functions within the system.'
),
(
  5,
  'multiple_choice',
  'application',
  'A conference room uses several sources, a matrix switcher, two displays, and an audio DSP. What should a technician verify when a new source is added?',
  '[{"key":"A","text":"That the new source format, routing, EDID behavior, audio path, control assignment, and destination compatibility all align with the system design"},{"key":"B","text":"Only that the source powers on"},{"key":"C","text":"Only that one display shows an image"},{"key":"D","text":"That every existing source is reconfigured"}]'::jsonb,
  '["A"]'::jsonb,
  'Adding a source can affect multiple parts of the AV path and should be evaluated as an integrated system change.'
),
(
  6,
  'multiple_choice',
  'application',
  'A matrix switcher feeds displays with different supported resolutions. What is the BEST design consideration?',
  '[{"key":"A","text":"Determine how EDID, scaling, and source-format selection will provide compatible signals to all required destinations"},{"key":"B","text":"Set every source to its highest possible resolution regardless of display capability"},{"key":"C","text":"Disable all display capability communication"},{"key":"D","text":"Use amplifier gain to compensate for resolution differences"}]'::jsonb,
  '["A"]'::jsonb,
  'Mixed display capabilities require deliberate management of source formats, scaling, and EDID behavior.'
),
(
  7,
  'multiple_choice',
  'application',
  'A distributed audio system has multiple rooms with different loudspeaker quantities and listening requirements. What should guide amplifier and DSP configuration?',
  '[{"key":"A","text":"The intended zone design, loudspeaker load, gain structure, processing requirements, and expected listening level for each area"},{"key":"B","text":"Using identical settings for every room regardless of design"},{"key":"C","text":"Setting all amplifier channels to maximum gain"},{"key":"D","text":"Routing every source to every zone permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'Audio configuration should reflect the electrical load and acoustic requirements of each zone.'
),
(
  8,
  'multiple_choice',
  'application',
  'An AV-over-network system is being deployed across several switches. What is the BEST coordination approach?',
  '[{"key":"A","text":"Confirm the AV traffic requirements, switch capabilities, segmentation, multicast behavior, bandwidth, and network configuration with the network design"},{"key":"B","text":"Assume any network switch will automatically support the AV traffic"},{"key":"C","text":"Place every device on an unmanaged network without planning"},{"key":"D","text":"Configure only the AV endpoints and ignore the switching infrastructure"}]'::jsonb,
  '["A"]'::jsonb,
  'Networked AV depends on both endpoint configuration and suitable network architecture.'
),
(
  9,
  'multiple_choice',
  'application',
  'A video wall uses multiple displays to present one large image. What must the system design coordinate?',
  '[{"key":"A","text":"Source resolution, processing, display arrangement, scaling, orientation, and image mapping across the complete wall"},{"key":"B","text":"Only the power connections"},{"key":"C","text":"Only the loudspeaker layout"},{"key":"D","text":"Only the display manufacturer"}]'::jsonb,
  '["A"]'::jsonb,
  'A video wall requires coordinated processing and display configuration so one image is mapped correctly across multiple panels.'
),
(
  10,
  'multiple_choice',
  'application',
  'A room contains separate presentation and background-music sources that must feed different destinations simultaneously. What AV capability is MOST important?',
  '[{"key":"A","text":"Independent routing and processing paths that allow different sources to serve different destinations at the same time"},{"key":"B","text":"A single fixed source connection"},{"key":"C","text":"One shared volume control for all devices"},{"key":"D","text":"A single display input"}]'::jsonb,
  '["A"]'::jsonb,
  'Independent routing allows an integrated AV system to support multiple simultaneous use cases.'
),
(
  11,
  'multiple_choice',
  'application',
  'A systems designer specifies balanced audio connections between rack devices over longer analog runs. What is the primary benefit?',
  '[{"key":"A","text":"Balanced connections help reject common-mode noise when used with compatible equipment and proper wiring"},{"key":"B","text":"They increase video resolution"},{"key":"C","text":"They eliminate the need for amplification"},{"key":"D","text":"They automatically configure DSP routing"}]'::jsonb,
  '["A"]'::jsonb,
  'Balanced analog audio is commonly used to improve noise rejection over appropriate interconnections.'
),
(
  12,
  'scenario',
  'scenario',
  'A training room has three sources, two displays, and an audio system. The client wants any source on either display while independently selecting which source audio plays through the room speakers. What is the BEST architecture?',
  '[{"key":"A","text":"Use video routing that independently serves each display and an audio path that can separately select, process, and route source audio to the room system"},{"key":"B","text":"Hardwire one source permanently to both displays and speakers"},{"key":"C","text":"Route loudspeaker outputs through the video matrix"},{"key":"D","text":"Require both displays and the audio system to use the same source at all times"}]'::jsonb,
  '["A"]'::jsonb,
  'The requested experience requires independent video destination routing and separate audio-source selection.'
),
(
  13,
  'scenario',
  'scenario',
  'A 4K source works directly with a new display but produces no image when routed through an older distribution device. What is the BEST design-level response?',
  '[{"key":"A","text":"Compare the required video format and bandwidth with the distribution device capabilities and select compatible configuration, scaling, transport, or hardware as needed"},{"key":"B","text":"Replace the new display immediately"},{"key":"C","text":"Increase amplifier gain"},{"key":"D","text":"Assume the source cannot output 4K"}]'::jsonb,
  '["A"]'::jsonb,
  'The intermediate distribution path must support the signal format and bandwidth required between source and display.'
),
(
  14,
  'scenario',
  'scenario',
  'A divisible conference room can operate as one large room or two independent rooms. What is the BEST AV design approach?',
  '[{"key":"A","text":"Define routing, audio processing, control, source access, and room-combine states so the system behaves correctly in both combined and divided modes"},{"key":"B","text":"Use one fixed routing state for all room configurations"},{"key":"C","text":"Require technicians to repatch the rack whenever the wall moves"},{"key":"D","text":"Disable one half of the AV system when the room is divided"}]'::jsonb,
  '["A"]'::jsonb,
  'Divisible spaces require coordinated AV states that change routing and behavior with the room configuration.'
),
(
  15,
  'scenario',
  'scenario',
  'A multi-zone audio system needs announcements to override normal program audio in selected areas. What is the BEST system approach?',
  '[{"key":"A","text":"Use DSP routing and priority logic that can interrupt or duck program audio in the intended zones while preserving normal operation elsewhere"},{"key":"B","text":"Wire the announcement microphone directly in parallel with every loudspeaker"},{"key":"C","text":"Set all program sources permanently to zero volume"},{"key":"D","text":"Require manual cable changes for every announcement"}]'::jsonb,
  '["A"]'::jsonb,
  'Priority audio behavior should be implemented through controlled routing and processing rather than improvised wiring changes.'
),
(
  16,
  'scenario',
  'scenario',
  'A client wants identical content on twelve displays throughout a facility, but some runs exceed the practical distance of the direct source connection. What is the BEST approach?',
  '[{"key":"A","text":"Use an appropriate distribution and transport architecture designed for the required distances, signal format, destination count, and system control"},{"key":"B","text":"Extend every direct cable beyond its supported distance and hope the signal remains stable"},{"key":"C","text":"Install twelve independent sources with no coordination"},{"key":"D","text":"Reduce loudspeaker volume to improve video distance"}]'::jsonb,
  '["A"]'::jsonb,
  'Large AV distribution systems require transport methods appropriate to distance, format, scale, and destination count.'
),
(
  17,
  'scenario',
  'scenario',
  'A DSP-based conference system has microphones, program audio, conferencing audio, and ceiling loudspeakers. Users complain that far-end participants hear room audio returned to them. What design function should be reviewed?',
  '[{"key":"A","text":"The conferencing audio routing, acoustic echo-cancellation reference, microphone processing, and send/receive signal relationships"},{"key":"B","text":"The video display aspect ratio"},{"key":"C","text":"The loudspeaker mounting hardware only"},{"key":"D","text":"The source-device labeling"}]'::jsonb,
  '["A"]'::jsonb,
  'Conferencing audio requires deliberate routing and echo-management relationships between microphones, loudspeakers, and far-end audio.'
),
(
  18,
  'scenario',
  'scenario',
  'A project manager sees that the AV drawings show one signal architecture, but field substitutions have changed several device capabilities. What is the BEST response before final configuration?',
  '[{"key":"A","text":"Reconcile the actual equipment with the design, verify compatibility and required changes, and update the approved documentation before relying on the original configuration plan"},{"key":"B","text":"Configure the system exactly as originally drawn regardless of substitutions"},{"key":"C","text":"Ignore the drawings entirely"},{"key":"D","text":"Replace every substituted device automatically"}]'::jsonb,
  '["A"]'::jsonb,
  'Field substitutions can change AV capabilities and should be reconciled with the intended signal architecture and documentation.'
),
(
  19,
  'scenario',
  'scenario',
  'A client wants one central rack to serve several rooms with independent source selection and volume control. What is the BEST systems-level design principle?',
  '[{"key":"A","text":"Create clearly defined source, distribution, processing, amplification, control, and destination paths for each room while sharing infrastructure where appropriate"},{"key":"B","text":"Connect every room to the same fixed source and volume level"},{"key":"C","text":"Avoid documenting room-specific routing"},{"key":"D","text":"Use display speakers for every audio zone regardless of requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Centralized AV can share infrastructure while still preserving independent routing and control for individual spaces.'
),
(
  20,
  'scenario',
  'scenario',
  'A complex AV project includes local sources, streaming sources, matrix distribution, DSP audio, amplification, displays, conferencing, and control integration. What is the BEST pre-handoff technical review?',
  '[{"key":"A","text":"Verify that the installed architecture matches the approved design, signal formats and routing are compatible, audio and video paths are complete, device assignments are documented, and integration dependencies are ready for final system validation"},{"key":"B","text":"Confirm only that every device powers on"},{"key":"C","text":"Skip architecture review because individual devices were tested"},{"key":"D","text":"Remove signal-flow documentation after programming"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex AV systems require an integrated review of architecture, routing, compatibility, and documentation before final validation.'
);

create temporary table _seed_ci_av_systems_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_av_systems_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What is the primary responsibility of an expert-level AV systems practitioner?',
  '[{"key":"A","text":"To make system-level decisions that balance signal integrity, compatibility, usability, performance, scalability, serviceability, and integration across the complete AV architecture"},{"key":"B","text":"To focus only on individual device installation"},{"key":"C","text":"To select the most expensive equipment available"},{"key":"D","text":"To avoid documenting design decisions"}]'::jsonb,
  '["A"]'::jsonb,
  'Expert AV work requires judgment across the complete system rather than isolated device-level decisions.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why is standards-based system architecture important in large AV deployments?',
  '[{"key":"A","text":"It creates consistent expectations for signal formats, interfaces, documentation, configuration, interoperability, and long-term support"},{"key":"B","text":"It guarantees every product from every manufacturer behaves identically"},{"key":"C","text":"It eliminates the need for commissioning"},{"key":"D","text":"It requires every project to use the same exact equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Standards help make AV systems more consistent, interoperable, serviceable, and scalable across projects.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the strongest reason to evaluate AV architecture for scalability before deployment?',
  '[{"key":"A","text":"Future sources, destinations, bandwidth, processing, control, and user requirements may grow beyond the initial design"},{"key":"B","text":"Every system must be oversized regardless of need"},{"key":"C","text":"Scalability matters only for loudspeaker quantity"},{"key":"D","text":"Scalability eliminates the need for documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'A scalable architecture can accommodate foreseeable growth without requiring unnecessary redesign.'
),
(
  4,
  'multiple_choice',
  'application',
  'A client wants to expand an existing centralized AV system from eight displays to thirty-two displays across several areas. What is the BEST first design action?',
  '[{"key":"A","text":"Review source count, destination count, routing requirements, bandwidth, transport distances, network or matrix capacity, control, and infrastructure before selecting the expansion architecture"},{"key":"B","text":"Add displays to existing outputs without checking capacity"},{"key":"C","text":"Replace every source device first"},{"key":"D","text":"Use passive splitters for all destinations regardless of signal requirements"}]'::jsonb,
  '["A"]'::jsonb,
  'Large expansions should begin with system requirements and capacity analysis rather than incremental connection changes.'
),
(
  5,
  'multiple_choice',
  'application',
  'A facility uses AV-over-network for hundreds of endpoints. What is the BEST system-level design practice?',
  '[{"key":"A","text":"Coordinate endpoint requirements with network bandwidth, multicast behavior, segmentation, redundancy, management, timing, and monitoring expectations"},{"key":"B","text":"Treat the network as an unlimited transparent transport layer"},{"key":"C","text":"Allow endpoints to be added without documentation"},{"key":"D","text":"Ignore switch architecture as long as endpoints power on"}]'::jsonb,
  '["A"]'::jsonb,
  'Large AV-over-network systems depend on coordinated endpoint and network architecture.'
),
(
  6,
  'multiple_choice',
  'application',
  'A client needs mission-critical presentation spaces where loss of one distribution component cannot disable all rooms. What design principle should be considered?',
  '[{"key":"A","text":"Reduce single points of failure through appropriate redundancy, segmentation, alternate paths, or localized functionality based on project requirements"},{"key":"B","text":"Place every room on one shared device to simplify the system"},{"key":"C","text":"Remove local source capability from all rooms"},{"key":"D","text":"Use identical cable labels for redundant paths"}]'::jsonb,
  '["A"]'::jsonb,
  'Critical environments may require architectural measures that limit the effect of a single component failure.'
),
(
  7,
  'multiple_choice',
  'application',
  'A complex AV system includes displays with different native resolutions and capabilities. What is the BEST architecture decision?',
  '[{"key":"A","text":"Define a deliberate EDID, scaling, format, and routing strategy that produces supported signals for all required destinations"},{"key":"B","text":"Force every source to the maximum possible format"},{"key":"C","text":"Disable all scaling everywhere"},{"key":"D","text":"Allow each endpoint to negotiate independently without considering shared paths"}]'::jsonb,
  '["A"]'::jsonb,
  'Mixed destination capabilities require an intentional format-management strategy across the system.'
),
(
  8,
  'multiple_choice',
  'application',
  'A project has inconsistent audio performance across similar rooms even though the same equipment models are used. What is the BEST leadership-level AV response?',
  '[{"key":"A","text":"Compare system design, DSP configuration, gain structure, loudspeaker deployment, room conditions, calibration standards, and documentation across rooms"},{"key":"B","text":"Increase amplifier gain in every room"},{"key":"C","text":"Replace all loudspeakers"},{"key":"D","text":"Assume identical equipment guarantees identical results"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent equipment does not guarantee consistent system performance when design, configuration, and room conditions differ.'
),
(
  9,
  'multiple_choice',
  'application',
  'A system designer proposes a major device substitution late in a project. What is the BEST technical review?',
  '[{"key":"A","text":"Evaluate signal formats, bandwidth, I/O, processing, control, power, physical requirements, interoperability, programming impact, documentation, and downstream dependencies before approval"},{"key":"B","text":"Approve it if the replacement has similar dimensions"},{"key":"C","text":"Approve it if the manufacturer name is familiar"},{"key":"D","text":"Evaluate only the purchase price"}]'::jsonb,
  '["A"]'::jsonb,
  'A substitution can affect the complete AV architecture and should be reviewed against every relevant system dependency.'
),
(
  10,
  'multiple_choice',
  'application',
  'A lead technician is standardizing AV rack builds across multiple projects. What is the BEST approach?',
  '[{"key":"A","text":"Establish repeatable standards for device layout, signal flow, cabling, labeling, power, thermal management, network connections, documentation, and service access"},{"key":"B","text":"Make every rack unique to each installer"},{"key":"C","text":"Standardize only the appearance of the rack"},{"key":"D","text":"Remove cable labels to reduce visual clutter"}]'::jsonb,
  '["A"]'::jsonb,
  'Rack standards should improve technical consistency, serviceability, documentation, and implementation quality.'
),
(
  11,
  'scenario',
  'scenario',
  'A campus AV system must distribute sources among twenty rooms, support local presentation in each room, allow centralized monitoring, and continue basic room operation if the central distribution layer is unavailable. What is the BEST architecture?',
  '[{"key":"A","text":"Use an architecture that combines centralized distribution and management with appropriate local room functionality and failure-domain separation"},{"key":"B","text":"Require every room to depend completely on one central device"},{"key":"C","text":"Remove all local inputs"},{"key":"D","text":"Build twenty unrelated systems with no shared management"}]'::jsonb,
  '["A"]'::jsonb,
  'The requirements call for centralized capability without making basic room operation entirely dependent on one central failure point.'
),
(
  12,
  'scenario',
  'scenario',
  'A client wants to move from baseband matrix distribution to AV-over-network across an occupied facility. What is the BEST planning approach?',
  '[{"key":"A","text":"Evaluate current and future endpoint counts, bandwidth, switching, multicast, segmentation, cabling, latency, management, control integration, migration phases, and operational risk before deployment"},{"key":"B","text":"Replace the matrix immediately and configure the network later"},{"key":"C","text":"Assume existing switches are sufficient because they already provide internet access"},{"key":"D","text":"Move every room at once without a migration plan"}]'::jsonb,
  '["A"]'::jsonb,
  'A distribution-platform migration affects both AV and network architecture and should be planned as a coordinated system change.'
),
(
  13,
  'scenario',
  'scenario',
  'A large venue uses multiple video processors, displays, confidence monitors, recording feeds, and streaming outputs. The client wants one source format to serve every destination reliably. What is the BEST design response?',
  '[{"key":"A","text":"Define a supported production format and use appropriate processing, scaling, conversion, and distribution so each destination receives a compatible signal"},{"key":"B","text":"Allow every source and destination to negotiate independently without coordination"},{"key":"C","text":"Set every device to its highest available format"},{"key":"D","text":"Use only display settings to solve all compatibility issues"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex multi-destination systems benefit from a deliberate format strategy and controlled processing.'
),
(
  14,
  'scenario',
  'scenario',
  'A divisible ballroom has four operating modes, multiple source locations, distributed loudspeakers, conferencing capability, and several displays. What is the BEST control and AV architecture approach?',
  '[{"key":"A","text":"Define each room mode as a coordinated system state covering video routing, audio DSP, source access, display behavior, conferencing, user control, and room-combine logic"},{"key":"B","text":"Require users to manually reconfigure every device when partitions move"},{"key":"C","text":"Use one fixed routing state for every room mode"},{"key":"D","text":"Disable conferencing whenever rooms are combined"}]'::jsonb,
  '["A"]'::jsonb,
  'Complex divisible spaces require coordinated AV states so multiple subsystems change together predictably.'
),
(
  15,
  'scenario',
  'scenario',
  'A company wants the same AV room standard deployed in fifty locations but local room sizes and use cases vary. What is the BEST strategy?',
  '[{"key":"A","text":"Create a modular reference architecture with defined core standards and approved variations for room size, capacity, acoustics, displays, sources, and functional requirements"},{"key":"B","text":"Install the exact same equipment quantities in every room"},{"key":"C","text":"Allow every site to invent a completely different system"},{"key":"D","text":"Standardize only the user-interface color"}]'::jsonb,
  '["A"]'::jsonb,
  'A reference architecture creates consistency while allowing controlled variation where site requirements differ.'
),
(
  16,
  'scenario',
  'scenario',
  'A high-profile executive room has excellent audio and video performance, but service requires removing several devices because cabling and rack access were poorly planned. What is the BEST design lesson?',
  '[{"key":"A","text":"Serviceability, access, labeling, cable management, rack layout, and maintainability are part of AV system design quality, not separate concerns"},{"key":"B","text":"Only user-facing performance matters"},{"key":"C","text":"Service teams should expect to dismantle systems routinely"},{"key":"D","text":"Remove documentation to reduce rack complexity"}]'::jsonb,
  '["A"]'::jsonb,
  'A successful AV system must perform well and remain practical to maintain and support over its lifecycle.'
),
(
  17,
  'scenario',
  'scenario',
  'A project includes AV, lighting, shades, conferencing, security, and environmental control. Each subsystem works independently, but the client expects unified room behavior. What is the BEST leadership-level approach?',
  '[{"key":"A","text":"Define subsystem responsibilities, integration interfaces, control ownership, event sequences, state dependencies, documentation, and coordinated validation before final deployment"},{"key":"B","text":"Assume independent subsystem operation guarantees successful integration"},{"key":"C","text":"Let each trade create overlapping control logic without coordination"},{"key":"D","text":"Integrate only after client training"}]'::jsonb,
  '["A"]'::jsonb,
  'Multi-system experiences require clearly defined interfaces and coordinated behavior across subsystem boundaries.'
),
(
  18,
  'scenario',
  'scenario',
  'A client requests 4K video distribution today but expects higher-resolution and higher-bandwidth formats during the system lifecycle. What is the BEST design decision?',
  '[{"key":"A","text":"Evaluate infrastructure, transport, distribution, cabling, switching, processing, and endpoint strategy for reasonable future bandwidth and format growth"},{"key":"B","text":"Design only for the minimum current requirement regardless of expected growth"},{"key":"C","text":"Replace all infrastructure every time a new format appears"},{"key":"D","text":"Assume current connectors guarantee future compatibility"}]'::jsonb,
  '["A"]'::jsonb,
  'Lifecycle planning should consider foreseeable format and bandwidth growth where it materially affects infrastructure decisions.'
),
(
  19,
  'scenario',
  'scenario',
  'A lead technician reviews several completed projects and finds repeated differences in source naming, port assignments, rack layout, DSP structure, and documentation. What is the BEST organizational response?',
  '[{"key":"A","text":"Develop and enforce AV implementation standards, templates, naming conventions, documentation practices, configuration baselines, and quality-review checkpoints"},{"key":"B","text":"Allow every project team to continue using unrelated methods"},{"key":"C","text":"Standardize only equipment brands"},{"key":"D","text":"Stop reviewing completed projects"}]'::jsonb,
  '["A"]'::jsonb,
  'Recurring inconsistency is best addressed through shared AV standards and repeatable implementation practices.'
),
(
  20,
  'scenario',
  'scenario',
  'An organization is designing a new enterprise AV standard after years of inconsistent systems, difficult service, incompatible substitutions, undocumented routing, and unpredictable user experiences. What is the BEST long-term strategy?',
  '[{"key":"A","text":"Create a governed AV systems framework covering reference architecture, approved technologies, signal-flow standards, network requirements, naming, configuration, documentation, installation, validation, serviceability, lifecycle planning, and controlled exceptions"},{"key":"B","text":"Select one equipment manufacturer and allow all other practices to remain inconsistent"},{"key":"C","text":"Let each installer decide the architecture independently"},{"key":"D","text":"Focus only on reducing initial equipment cost"}]'::jsonb,
  '["A"]'::jsonb,
  'A mature AV program requires an integrated technical framework that improves consistency, performance, serviceability, and lifecycle management.'
);

do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := 'b2ddce5e-4717-4f2b-bf49-2c5af78ff7b1';
  v_l1_role_id uuid := '32ea5f16-dd4a-42cf-9acf-0b6a1b58de6f';
  v_l2_role_id uuid := '006a91b3-38dc-4d13-9532-f22d839af945';
  v_l3_role_id uuid := '925c6250-5991-4179-afed-e47fa6a08a31';
  v_l4_role_id uuid := 'cefefd09-9d5b-4a67-87a9-830180b5a016';
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
      and c.name = 'AV Systems'
      and c.is_current = true
  ) then
    raise exception 'Current AV Systems Master Competency not found';
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
    raise exception 'Current Technician I — Entry Level L1 AV Systems requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l2_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Logistics Manager'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Logistics Manager L2 AV Systems requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l3_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician II — Experienced'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Technician II — Experienced L3 AV Systems requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l4_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Technician III — Lead Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Technician III — Lead Technician L4 AV Systems requirement not found';
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

  if not exists (
    select 1
    from public.master_competency_assessment_standards s
    where s.master_competency_template_id = v_competency_id
      and s.target_level = 4
      and s.is_current = true
      and s.required_question_count = 20
      and s.foundational_count = 3
      and s.application_count = 7
      and s.scenario_count = 10
  ) then
    raise exception 'Expected current L4 assessment standard 20 / 3 / 7 / 10 not found';
  end if;

  -- ========================================================================
  -- Seed Level 1
  -- ========================================================================

  v_level := 1;
  v_role_template_id := v_l1_role_id;
  v_assessment_name := 'AV Systems — Level 1 Competency Assessment';

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
    select * from _seed_ci_av_systems_l1_questions
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
        'AV Systems',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
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
      'IntegrateU AV Systems L1 production assessment v1.0.',
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
        'AV Systems',
        v_row.difficulty,
        true,
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
        'IntegrateU AV Systems L1 production assessment v1.0.',
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
  v_assessment_name := 'AV Systems — Level 2 Competency Assessment';

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
    select * from _seed_ci_av_systems_l2_questions
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
        'AV Systems',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
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
      'IntegrateU AV Systems L2 production assessment v1.0.',
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
        'AV Systems',
        v_row.difficulty,
        true,
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
        'IntegrateU AV Systems L2 production assessment v1.0.',
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
  v_assessment_name := 'AV Systems — Level 3 Competency Assessment';

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
    select * from _seed_ci_av_systems_l3_questions
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
        'AV Systems',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
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
      'IntegrateU AV Systems L3 production assessment v1.0.',
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
        'AV Systems',
        v_row.difficulty,
        true,
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
        'IntegrateU AV Systems L3 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

  -- ========================================================================
  -- Seed Level 4
  -- ========================================================================

  v_level := 4;
  v_role_template_id := v_l4_role_id;
  v_assessment_name := 'AV Systems — Level 4 Competency Assessment';

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
    select * from _seed_ci_av_systems_l4_questions
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
        'AV Systems',
        v_row.question_type,
        v_row.difficulty,
        v_row.prompt,
        v_row.options,
        1,
        true,
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
      'IntegrateU AV Systems L4 production assessment v1.0.',
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
        'AV Systems',
        v_row.difficulty,
        true,
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
        'IntegrateU AV Systems L4 production assessment v1.0.',
        'Rationale: ' || v_row.rationale
      )
    where not exists (
      select 1
      from public.assessment_question_answer_keys existing_key
      where existing_key.question_id = v_assessment_question_id
    );
  end loop;

end;
$$;

commit;

-- ============================================================================
-- VERIFICATION 1 — EXACT PER-LEVEL PRODUCTION COUNTS
-- Expected:
--   Level 1 -> 20 / 20 / 8 / 8 / 4
--   Level 2 -> 20 / 20 / 5 / 9 / 6
--   Level 3 -> 20 / 20 / 4 / 7 / 9
--   Level 4 -> 20 / 20 / 3 / 7 / 10
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
   '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
 and aq.source_master_question_id is not null
left join public.assessment_question_answer_keys ak
  on ak.question_id = aq.id
where a.client_id is null
  and a.is_current = true
  and a.type = 'competency'
  and a.master_competency_template_id =
    '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
  and a.target_level in (1,2,3,4)
group by a.id, a.target_level, a.name
order by a.target_level;

-- ============================================================================
-- VERIFICATION 2 — ROLE APPLICABILITY COUNTS
-- Expected:
--   Level 1 Installer / Helper      -> 20
--   Level 2 Design & Sales Engineer -> 20
--   Level 3 Service & Repair        -> 20
--   Level 4 Senior / Lead           -> 20
-- ============================================================================

with q as (
  select aq.source_master_question_id, a.target_level
  from public.assessments a
  join public.assessment_questions aq on aq.assessment_id = a.id
  where a.client_id is null
    and a.is_current = true
    and a.type = 'competency'
    and a.master_competency_template_id =
      '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
    and a.target_level in (1,2,3,4)
    and aq.master_competency_template_id =
      '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
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
    '7a7a4a06-45d7-4bca-af67-ede5df4fb915'::uuid)
  or
  (q.target_level = 2 and ra.master_role_template_id =
    '0264d850-dbb5-4c65-b968-78e49e46e186'::uuid)
  or
  (q.target_level = 3 and ra.master_role_template_id =
    '6c7f72f9-7b8f-4fb9-81ba-bfebcfcc2a52'::uuid)
  or
  (q.target_level = 4 and ra.master_role_template_id =
    'df49a251-f3d9-44f1-84a2-dd62858bffb0'::uuid)
group by q.target_level
order by q.target_level;

-- ============================================================================
-- VERIFICATION 3 — COVERAGE STATUS
-- ============================================================================

select *
from public.wri_master_competency_assessment_coverage()
where master_competency_template_id =
  '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid;

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
    '9d3ea4c3-0c12-4177-a6df-db5f565c03c4'::uuid
  and a.target_level in (1,2,3,4)
group by a.target_level
having count(*) > 1;
