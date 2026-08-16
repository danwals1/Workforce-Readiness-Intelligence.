-- ============================================================================
-- IntegrateU Workforce Readiness Intelligence
-- 0149_ci_low_voltage_fundamentals_multilevel_production_question_banks.sql
--
-- Production Master Question Banks:
--   Competency: Low-Voltage Fundamentals
--   Level 1: 20 questions = 8 foundational / 8 application / 4 scenario
--   Level 2: 20 questions = 5 foundational / 9 application / 6 scenario
--   Level 3: 20 questions = 4 foundational / 7 application / 9 scenario
--   Level 4: 20 questions = 3 foundational / 7 application / 10 scenario
--
-- Representative role validation:
--   Logistics Manager   -> Level 1
--   Operations Manager  -> Level 2
--   Systems Designer    -> Level 3
--   Service Technician  -> Level 4
--
-- Each target level receives its own current assessment family.
-- Existing exact-prompt Master Questions and source-linked snapshots are reused.
--
-- Content note: these questions assess low-voltage fundamentals across
-- progressively higher levels of recognition, application, troubleshooting,
-- system judgment, and cross-system technical understanding.
-- ============================================================================

begin;

create temporary table _seed_ci_low_voltage_fundamentals_l1_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_low_voltage_fundamentals_l1_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'In systems integration, what does low voltage generally describe?',
  '[{"key":"A","text":"Systems operating at lower electrical voltages than standard line-voltage building power systems"},{"key":"B","text":"Any system that uses wireless communication"},{"key":"C","text":"Only audio systems"},{"key":"D","text":"Circuits that contain no electrical energy"}]'::jsonb,
  '["A"]'::jsonb,
  'Low-voltage systems operate below typical building line-voltage power and commonly support communications, control, AV, networking, security, and related integrated systems.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does voltage represent in an electrical circuit?',
  '[{"key":"A","text":"Electrical potential difference between two points"},{"key":"B","text":"The physical diameter of a conductor"},{"key":"C","text":"The amount of network traffic"},{"key":"D","text":"Opposition to current flow"}]'::jsonb,
  '["A"]'::jsonb,
  'Voltage is electrical potential difference and is one of the basic electrical quantities technicians must recognize when working with powered devices.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What does electrical current describe?',
  '[{"key":"A","text":"The flow of electric charge"},{"key":"B","text":"The length of a cable run"},{"key":"C","text":"The resistance of insulation"},{"key":"D","text":"The number of devices on a network"}]'::jsonb,
  '["A"]'::jsonb,
  'Current is the flow of electric charge through a circuit.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What does electrical resistance describe?',
  '[{"key":"A","text":"Opposition to the flow of electric current"},{"key":"B","text":"The maximum data speed of a cable"},{"key":"C","text":"The voltage produced by a switch"},{"key":"D","text":"The physical strength of a connector"}]'::jsonb,
  '["A"]'::jsonb,
  'Resistance is opposition to current flow and is commonly measured in ohms.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes the basic difference between AC and DC?',
  '[{"key":"A","text":"AC periodically changes direction or polarity, while DC maintains consistent polarity"},{"key":"B","text":"AC is used only for audio and DC only for video"},{"key":"C","text":"DC contains no electrical current"},{"key":"D","text":"There is no meaningful electrical difference"}]'::jsonb,
  '["A"]'::jsonb,
  'Alternating current changes direction or polarity periodically, while direct current maintains consistent polarity.'
),
(
  6,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a power connection to an integrated-system device?',
  '[{"key":"A","text":"To provide the electrical energy required for the device to operate"},{"key":"B","text":"To carry every audio and video signal"},{"key":"C","text":"To identify the room where the device is installed"},{"key":"D","text":"To replace configuration and programming"}]'::jsonb,
  '["A"]'::jsonb,
  'A power connection supplies operating energy to equipment; it is distinct from signal, control, and data connections.'
),
(
  7,
  'multiple_choice',
  'foundational',
  'What is a signal path?',
  '[{"key":"A","text":"The route a signal follows from its source through system components to its destination"},{"key":"B","text":"The route technicians take through a building"},{"key":"C","text":"Only the AC branch circuit serving an equipment rack"},{"key":"D","text":"A list of device serial numbers"}]'::jsonb,
  '["A"]'::jsonb,
  'Understanding signal paths helps technicians follow how audio, video, data, control, and other information moves through a system.'
),
(
  8,
  'multiple_choice',
  'foundational',
  'A device has positive (+) and negative (-) power terminals. What does this indicate?',
  '[{"key":"A","text":"Polarity must be observed when making the connection"},{"key":"B","text":"Either terminal can be connected interchangeably"},{"key":"C","text":"The connection carries Ethernet only"},{"key":"D","text":"The device cannot use DC power"}]'::jsonb,
  '["A"]'::jsonb,
  'Marked positive and negative terminals indicate a polarity-sensitive connection that should be wired according to the manufacturer specification.'
),
(
  9,
  'multiple_choice',
  'application',
  'A device is labeled for 12 VDC input. Which action is BEST before connecting a power supply?',
  '[{"key":"A","text":"Verify that the supply provides the specified voltage, polarity, and adequate current capacity"},{"key":"B","text":"Use any power supply with a connector that fits"},{"key":"C","text":"Connect it to building line voltage"},{"key":"D","text":"Increase the voltage so the device starts faster"}]'::jsonb,
  '["A"]'::jsonb,
  'Connector fit alone does not establish electrical compatibility; voltage, polarity, current capacity, and manufacturer requirements must be verified.'
),
(
  10,
  'multiple_choice',
  'application',
  'Project documentation shows separate power and signal connections for a device. Why should the technician distinguish between them?',
  '[{"key":"A","text":"They perform different functions and may have different connection, routing, and installation requirements"},{"key":"B","text":"They are always interchangeable"},{"key":"C","text":"Signal cables never contain electrical energy"},{"key":"D","text":"Power connections are relevant only after commissioning"}]'::jsonb,
  '["A"]'::jsonb,
  'Power and signal connections serve different purposes and must be installed according to the system design and applicable requirements.'
),
(
  11,
  'multiple_choice',
  'application',
  'A speaker cable has one conductor identified with a stripe. Why is maintaining consistent conductor identification useful?',
  '[{"key":"A","text":"It helps maintain consistent polarity and termination throughout the signal path"},{"key":"B","text":"It increases amplifier output power"},{"key":"C","text":"It changes the cable impedance"},{"key":"D","text":"It eliminates the need for labeling"}]'::jsonb,
  '["A"]'::jsonb,
  'Consistent conductor identification helps maintain correct polarity and reduces termination errors.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician is tracing why a display has no image. Which approach BEST applies signal-path fundamentals?',
  '[{"key":"A","text":"Follow the path from source through each intermediate device and connection to the display"},{"key":"B","text":"Replace the display immediately"},{"key":"C","text":"Change every system setting at once"},{"key":"D","text":"Ignore upstream devices because only the display matters"}]'::jsonb,
  '["A"]'::jsonb,
  'Following the signal path systematically helps isolate where a signal is lost or altered.'
),
(
  13,
  'multiple_choice',
  'application',
  'A low-voltage device does not power on after installation. What should be checked FIRST?',
  '[{"key":"A","text":"Expected power source, connections, polarity where applicable, and manufacturer power requirements"},{"key":"B","text":"Every unrelated programming setting"},{"key":"C","text":"The client network password"},{"key":"D","text":"Whether the device enclosure matches the room color"}]'::jsonb,
  '["A"]'::jsonb,
  'Basic troubleshooting starts by verifying the required power source and physical connections before assuming equipment failure.'
),
(
  14,
  'multiple_choice',
  'application',
  'Two cables look physically similar, but one is specified for a network connection and the other for speaker-level audio. What should the installer do?',
  '[{"key":"A","text":"Use the cable type specified for each circuit and application"},{"key":"B","text":"Use whichever cable is closest"},{"key":"C","text":"Assume appearance determines compatibility"},{"key":"D","text":"Splice the two together so either can be used"}]'::jsonb,
  '["A"]'::jsonb,
  'Cable selection should follow system requirements rather than visual similarity alone.'
),
(
  15,
  'multiple_choice',
  'application',
  'A device requires 24 VDC, but the available supply is labeled 12 VDC. What is the BEST action?',
  '[{"key":"A","text":"Do not connect it until a compatible power source is confirmed"},{"key":"B","text":"Connect it because both supplies are DC"},{"key":"C","text":"Reverse polarity to compensate for the lower voltage"},{"key":"D","text":"Connect two signal conductors together to increase voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'A device should receive power within its specified electrical requirements; both being DC does not make different voltages interchangeable.'
),
(
  16,
  'multiple_choice',
  'application',
  'A cable is terminated correctly at one end but connected to the wrong destination at the other. What fundamental problem exists?',
  '[{"key":"A","text":"The intended signal path is incorrect"},{"key":"B","text":"The cable automatically becomes line voltage"},{"key":"C","text":"The conductor resistance becomes zero"},{"key":"D","text":"The device polarity no longer matters"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct termination alone is not enough; the cable must connect the intended source and destination to establish the proper signal path.'
),
(
  17,
  'scenario',
  'scenario',
  'A replacement control device physically fits the existing mount and uses the same connector, but its label specifies a different input voltage from the original device. What should the technician do?',
  '[{"key":"A","text":"Connect it because the connector fits"},{"key":"B","text":"Verify the required voltage, polarity, current, and manufacturer compatibility before applying power"},{"key":"C","text":"Apply power briefly and watch for smoke"},{"key":"D","text":"Assume all low-voltage devices use interchangeable power"}]'::jsonb,
  '["B"]'::jsonb,
  'Physical fit and connector compatibility do not prove electrical compatibility; power requirements must be confirmed before energizing equipment.'
),
(
  18,
  'scenario',
  'scenario',
  'While installing a low-voltage system, a technician encounters line-voltage wiring blocking the planned cable route. The technician is not qualified or authorized to modify it. What is the BEST action?',
  '[{"key":"A","text":"Move the line-voltage wiring carefully"},{"key":"B","text":"Disconnect it temporarily and restore it later"},{"key":"C","text":"Stop the affected work and communicate the condition so it can be handled by an appropriately qualified person"},{"key":"D","text":"Ignore it and force the low-voltage cable through the same space"}]'::jsonb,
  '["C"]'::jsonb,
  'Technicians should recognize the limits of their qualification and authorization instead of modifying electrical systems outside their scope.'
),
(
  19,
  'scenario',
  'scenario',
  'A newly installed powered device does not start. The cable is connected, but the technician has not verified the power supply output or polarity. What is the BEST next step?',
  '[{"key":"A","text":"Replace the device immediately"},{"key":"B","text":"Verify the specified supply output, polarity, connections, and device requirements before replacing equipment"},{"key":"C","text":"Increase the supply voltage"},{"key":"D","text":"Change unrelated network settings"}]'::jsonb,
  '["B"]'::jsonb,
  'A systematic check of basic power fundamentals should occur before equipment is condemned or unrelated changes are made.'
),
(
  20,
  'scenario',
  'scenario',
  'An audio source is operating and the amplifier is powered, but no sound reaches the room. The technician confirms the speaker itself works. What is the BEST fundamental troubleshooting approach?',
  '[{"key":"A","text":"Trace the complete signal path and verify each connection and component between the source, amplifier, and speaker"},{"key":"B","text":"Replace every component at once"},{"key":"C","text":"Increase the amplifier gain to maximum"},{"key":"D","text":"Assume the problem must be the speaker cable"}]'::jsonb,
  '["A"]'::jsonb,
  'Systematic signal-path tracing helps determine where the expected signal stops rather than relying on assumptions or broad component replacement.'
);

create temporary table _seed_ci_low_voltage_fundamentals_l2_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_low_voltage_fundamentals_l2_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'What relationship does Ohm''s law describe?',
  '[{"key":"A","text":"The relationship among voltage, current, and resistance"},{"key":"B","text":"The relationship between cable color and room location"},{"key":"C","text":"The relationship between network speed and screen size"},{"key":"D","text":"The relationship between speaker size and rack height"}]'::jsonb,
  '["A"]'::jsonb,
  'Ohm''s law describes the relationship among voltage, current, and resistance and supports basic electrical reasoning in low-voltage systems.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What does electrical power, expressed in watts, represent?',
  '[{"key":"A","text":"The rate at which electrical energy is used or delivered"},{"key":"B","text":"Only the resistance of a conductor"},{"key":"C","text":"The number of conductors in a cable"},{"key":"D","text":"The maximum network address count"}]'::jsonb,
  '["A"]'::jsonb,
  'Watts express electrical power, or the rate at which electrical energy is delivered or consumed.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is conductor size relevant in a powered low-voltage circuit?',
  '[{"key":"A","text":"It affects resistance, voltage drop, and current-carrying capability"},{"key":"B","text":"It determines the device IP address"},{"key":"C","text":"It changes digital resolution"},{"key":"D","text":"It identifies which manufacturer made the device"}]'::jsonb,
  '["A"]'::jsonb,
  'Conductor size affects electrical resistance, allowable current, and voltage drop over distance.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is voltage drop?',
  '[{"key":"A","text":"A reduction in voltage along a circuit caused by resistance and current flow"},{"key":"B","text":"A network packet being discarded"},{"key":"C","text":"A connector falling out of a device"},{"key":"D","text":"A reduction in audio file size"}]'::jsonb,
  '["A"]'::jsonb,
  'Voltage drop is the reduction in electrical potential along conductors as current flows through circuit resistance.'
),
(
  5,
  'multiple_choice',
  'foundational',
  'What is the purpose of a fuse or other overcurrent protection device?',
  '[{"key":"A","text":"To interrupt excessive current under specified fault or overload conditions"},{"key":"B","text":"To improve network bandwidth"},{"key":"C","text":"To correct signal polarity automatically"},{"key":"D","text":"To increase power-supply voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Overcurrent protection is intended to interrupt current when specified unsafe or abnormal conditions occur.'
),
(
  6,
  'multiple_choice',
  'application',
  'A 12 VDC device located far from its power supply operates intermittently only when its load increases. What electrical condition should be investigated?',
  '[{"key":"A","text":"Excessive voltage drop in the power circuit"},{"key":"B","text":"Incorrect room labeling"},{"key":"C","text":"Excessive network bandwidth"},{"key":"D","text":"A missing video EDID"}]'::jsonb,
  '["A"]'::jsonb,
  'Higher load current can increase voltage drop, potentially reducing the voltage at the device below its operating requirement.'
),
(
  7,
  'multiple_choice',
  'application',
  'A power supply is rated 24 VDC at 2 A. Several connected devices together may require more than 2 A. What is the BEST conclusion?',
  '[{"key":"A","text":"The supply may be undersized for the combined load"},{"key":"B","text":"The voltage automatically increases to compensate"},{"key":"C","text":"Current ratings do not matter in low-voltage systems"},{"key":"D","text":"The devices will automatically use less current with no effect"}]'::jsonb,
  '["A"]'::jsonb,
  'The combined device load should remain within the power supply''s rated capacity and applicable design margin.'
),
(
  8,
  'multiple_choice',
  'application',
  'A technician measures correct voltage at the power supply but significantly lower voltage at the remote device while it is operating. What should be investigated next?',
  '[{"key":"A","text":"Conductor resistance, run length, terminations, and load current"},{"key":"B","text":"The device hostname only"},{"key":"C","text":"The room paint color"},{"key":"D","text":"The video resolution"}]'::jsonb,
  '["A"]'::jsonb,
  'A voltage difference between source and load under operating conditions points toward voltage drop caused by wiring, connections, distance, or current.'
),
(
  9,
  'multiple_choice',
  'application',
  'A device requires 24 VDC and 1.5 A maximum. Which supply is the BEST basic match, assuming manufacturer requirements allow it?',
  '[{"key":"A","text":"24 VDC with a current capacity greater than or equal to 1.5 A"},{"key":"B","text":"12 VDC at 10 A"},{"key":"C","text":"48 VDC at 0.5 A"},{"key":"D","text":"Any supply with the same connector shape"}]'::jsonb,
  '["A"]'::jsonb,
  'The supply voltage must match the device requirement, and the supply must be capable of providing at least the required current.'
),
(
  10,
  'multiple_choice',
  'application',
  'A field technician finds a loose screw-terminal connection in a powered low-voltage circuit. Why can this matter even if the conductor is still touching the terminal?',
  '[{"key":"A","text":"A poor connection can add resistance, create voltage drop, and cause intermittent operation"},{"key":"B","text":"It automatically changes DC to AC"},{"key":"C","text":"It increases network address space"},{"key":"D","text":"It changes the cable category"}]'::jsonb,
  '["A"]'::jsonb,
  'Loose or poor electrical connections can increase resistance and lead to unstable voltage, heat, or intermittent equipment behavior.'
),
(
  11,
  'multiple_choice',
  'application',
  'A rack contains several low-voltage power supplies. What is the BEST practice when tracing a device power problem?',
  '[{"key":"A","text":"Confirm the specific source, output rating, conductor path, and destination for that device"},{"key":"B","text":"Assume every supply serves every device"},{"key":"C","text":"Replace all supplies at once"},{"key":"D","text":"Ignore labeling because voltage can be identified by connector shape"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate tracing requires identifying the actual power source and complete circuit path instead of assuming connections.'
),
(
  12,
  'multiple_choice',
  'application',
  'A technician must verify whether a powered low-voltage circuit has continuity after power has been safely removed. Which tool function is commonly appropriate?',
  '[{"key":"A","text":"Continuity or resistance measurement, used according to the meter and equipment instructions"},{"key":"B","text":"Network throughput test"},{"key":"C","text":"Audio gain adjustment"},{"key":"D","text":"Video scaling"}]'::jsonb,
  '["A"]'::jsonb,
  'Continuity or resistance measurements can help verify conductor paths when the circuit is properly deenergized and the test is appropriate.'
),
(
  13,
  'multiple_choice',
  'application',
  'A device powers up but resets whenever another device is activated on the same low-voltage supply. What is the BEST initial electrical investigation?',
  '[{"key":"A","text":"Check total load, supply capacity, voltage at the device under load, and shared connections"},{"key":"B","text":"Reprogram every device"},{"key":"C","text":"Replace the network switch first"},{"key":"D","text":"Increase supply voltage beyond the equipment rating"}]'::jsonb,
  '["A"]'::jsonb,
  'Load-related resets can result from inadequate supply capacity, voltage drop, or poor shared connections.'
),
(
  14,
  'multiple_choice',
  'application',
  'A project uses a central DC supply to power multiple devices. Why is documenting each branch circuit useful?',
  '[{"key":"A","text":"It supports accurate load calculations, troubleshooting, service, and circuit identification"},{"key":"B","text":"It eliminates the need to verify device requirements"},{"key":"C","text":"It allows every branch to use unlimited current"},{"key":"D","text":"It automatically balances network traffic"}]'::jsonb,
  '["A"]'::jsonb,
  'Branch documentation improves system understanding and helps technicians verify loading and isolate faults.'
),
(
  15,
  'scenario',
  'scenario',
  'A project calls for several 24 VDC devices to share one supply. Individually each device is compatible, but their combined maximum current exceeds the supply rating. What is the BEST response?',
  '[{"key":"A","text":"Revise the power design so the connected load remains within appropriately rated supply capacity"},{"key":"B","text":"Proceed because each individual device uses 24 VDC"},{"key":"C","text":"Increase the supply output voltage"},{"key":"D","text":"Use smaller conductors so each device receives less current"}]'::jsonb,
  '["A"]'::jsonb,
  'Voltage compatibility alone is not enough; aggregate load must remain within the capacity of the power source and distribution design.'
),
(
  16,
  'scenario',
  'scenario',
  'A door-control device works correctly near the equipment room but becomes unreliable after being relocated 250 feet away using the same conductor size. The supply voltage is correct at the source. What is the BEST next step?',
  '[{"key":"A","text":"Evaluate voltage drop at the remote device under operating load and verify conductor sizing and terminations"},{"key":"B","text":"Replace the control software"},{"key":"C","text":"Increase source voltage without checking the device rating"},{"key":"D","text":"Assume distance cannot affect low-voltage power"}]'::jsonb,
  '["A"]'::jsonb,
  'Longer conductors increase resistance and can create significant voltage drop, especially under load.'
),
(
  17,
  'scenario',
  'scenario',
  'A technician finds that a replacement power supply has the correct voltage but a lower maximum current rating than the original. The connected system normally draws close to the original supply rating. What should the technician do?',
  '[{"key":"A","text":"Use a properly rated supply that meets the system load and manufacturer requirements"},{"key":"B","text":"Install the smaller supply because voltage is the only important rating"},{"key":"C","text":"Parallel random adapters without engineering review"},{"key":"D","text":"Reduce conductor size to limit current"}]'::jsonb,
  '["A"]'::jsonb,
  'A replacement supply must satisfy both voltage and load-capacity requirements rather than matching voltage alone.'
),
(
  18,
  'scenario',
  'scenario',
  'A control processor repeatedly reboots. Measurement at the processor shows 24 VDC with no load, but the voltage falls well below specification during startup. What is the BEST interpretation?',
  '[{"key":"A","text":"The power circuit may have inadequate capacity, excessive resistance, or voltage drop under load"},{"key":"B","text":"The processor must have the wrong IP address"},{"key":"C","text":"The no-load voltage proves the circuit is healthy"},{"key":"D","text":"The processor should be supplied with higher-than-rated voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'A circuit can appear normal without load but fail when current demand increases, making loaded measurements important.'
),
(
  19,
  'scenario',
  'scenario',
  'A technician measures continuity between two conductors that should be isolated from each other. What is the BEST next action?',
  '[{"key":"A","text":"Investigate for an unintended connection, termination error, or conductor fault before energizing the circuit"},{"key":"B","text":"Apply power to see whether the fault clears"},{"key":"C","text":"Ignore the reading because continuity cannot indicate wiring problems"},{"key":"D","text":"Increase the fuse rating"}]'::jsonb,
  '["A"]'::jsonb,
  'Unexpected continuity can indicate a short, crossed termination, or other unintended conductive path that should be resolved before power is applied.'
),
(
  20,
  'scenario',
  'scenario',
  'A system has intermittent power failures affecting several devices connected to one distribution point. Individual devices and branch cables test normally when disconnected. What is the BEST troubleshooting direction?',
  '[{"key":"A","text":"Focus on the shared supply, distribution connections, loading, and common upstream path"},{"key":"B","text":"Replace every downstream device"},{"key":"C","text":"Change all network addresses"},{"key":"D","text":"Assume several unrelated devices failed simultaneously"}]'::jsonb,
  '["A"]'::jsonb,
  'When multiple devices share the same symptom and individual branches appear healthy, the common upstream power path is a logical place to investigate.'
);

create temporary table _seed_ci_low_voltage_fundamentals_l3_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_low_voltage_fundamentals_l3_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 3 performance in Low-Voltage Fundamentals?',
  '[{"key":"A","text":"Recognizing basic cable colors only"},{"key":"B","text":"Independently applying electrical and signal-path fundamentals to verify, diagnose, and correct common low-voltage system problems"},{"key":"C","text":"Replacing equipment whenever a symptom appears"},{"key":"D","text":"Working only from memorized connector types"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 3 performance requires independent application of low-voltage fundamentals to real system conditions, including verification and troubleshooting.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'What is a dry-contact relay output?',
  '[{"key":"A","text":"A switching contact that does not inherently supply the controlled circuit voltage"},{"key":"B","text":"A relay that can be used only outdoors"},{"key":"C","text":"A network port without PoE"},{"key":"D","text":"A power supply with no current rating"}]'::jsonb,
  '["A"]'::jsonb,
  'A dry contact acts as a switch and normally requires the controlled circuit to provide its own appropriate electrical source.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'Why is a common electrical reference sometimes required between interconnected low-voltage devices?',
  '[{"key":"A","text":"Because some signal or control interfaces depend on both devices sharing the intended reference potential"},{"key":"B","text":"Because every communication protocol requires line voltage"},{"key":"C","text":"Because it increases conductor size"},{"key":"D","text":"Because it replaces signal wiring"}]'::jsonb,
  '["A"]'::jsonb,
  'Some low-voltage interfaces rely on a defined common reference; an incorrect or missing reference can prevent proper operation.'
),
(
  4,
  'multiple_choice',
  'foundational',
  'What is the primary purpose of a cable shield in an application where shielding is specified?',
  '[{"key":"A","text":"To help reduce unwanted electromagnetic interference from coupling into or out of the signal path"},{"key":"B","text":"To increase supply voltage"},{"key":"C","text":"To provide unlimited current capacity"},{"key":"D","text":"To replace the signal conductors"}]'::jsonb,
  '["A"]'::jsonb,
  'Properly implemented shielding can help control electromagnetic interference in susceptible signal circuits.'
),
(
  5,
  'multiple_choice',
  'application',
  'A relay interface provides only COM, NO, and NC terminals. The connected device requires 12 VDC to activate. What should the technician recognize?',
  '[{"key":"A","text":"The relay contacts switch a circuit, but an appropriate external source may still be required to provide the 12 VDC"},{"key":"B","text":"The NO terminal automatically produces 12 VDC"},{"key":"C","text":"COM always means electrical ground"},{"key":"D","text":"The relay converts network data into power"}]'::jsonb,
  '["A"]'::jsonb,
  'Dry relay contacts provide switching action rather than automatically supplying the controlled device voltage.'
),
(
  6,
  'multiple_choice',
  'application',
  'A device operates normally until a high-current accessory on the same supply activates. Which measurement is MOST useful next?',
  '[{"key":"A","text":"Voltage at the affected device while the accessory is operating"},{"key":"B","text":"Cable length with all equipment disconnected only"},{"key":"C","text":"Network hostname"},{"key":"D","text":"Display resolution"}]'::jsonb,
  '["A"]'::jsonb,
  'Measuring voltage under the actual load condition can reveal supply sag, excessive voltage drop, or shared-path problems.'
),
(
  7,
  'multiple_choice',
  'application',
  'A control input expects a dry-contact closure, but a technician applies an external voltage directly to it without verifying the specification. What is the fundamental concern?',
  '[{"key":"A","text":"The input may not be designed to accept externally applied voltage and could operate incorrectly or be damaged"},{"key":"B","text":"Dry contacts always require 120 VAC"},{"key":"C","text":"The input automatically becomes a network connection"},{"key":"D","text":"Voltage cannot affect control inputs"}]'::jsonb,
  '["A"]'::jsonb,
  'An interface designed to sense contact closure should not be assumed to accept an externally applied voltage.'
),
(
  8,
  'multiple_choice',
  'application',
  'A shielded control cable is terminated differently at opposite ends than the project detail specifies. What should the technician do?',
  '[{"key":"A","text":"Correct the termination to match the documented shielding and grounding method"},{"key":"B","text":"Assume shield termination never matters"},{"key":"C","text":"Connect the shield to every available terminal"},{"key":"D","text":"Remove the shield from the entire cable"}]'::jsonb,
  '["A"]'::jsonb,
  'Shield termination should follow the system design because incorrect bonding can reduce interference performance or create unintended current paths.'
),
(
  9,
  'multiple_choice',
  'application',
  'A power supply feeds several parallel device branches. One branch develops a short circuit. What design feature can help limit the effect on the rest of the system?',
  '[{"key":"A","text":"Appropriate branch protection or individually protected distribution outputs"},{"key":"B","text":"Larger video files"},{"key":"C","text":"Removing all circuit labels"},{"key":"D","text":"Increasing voltage above every device rating"}]'::jsonb,
  '["A"]'::jsonb,
  'Properly protected distribution can isolate faults and reduce the likelihood that one branch disables an entire shared system.'
),
(
  10,
  'multiple_choice',
  'application',
  'A technician measures the correct supply voltage with the load disconnected but nearly zero volts when the device is connected. What should be suspected?',
  '[{"key":"A","text":"A source-capacity problem, excessive circuit resistance, protection operation, or an abnormal load condition"},{"key":"B","text":"The unloaded measurement proves the power circuit is healthy"},{"key":"C","text":"The network switch must be offline"},{"key":"D","text":"The device firmware is definitely corrupted"}]'::jsonb,
  '["A"]'::jsonb,
  'A large voltage collapse under load indicates the power path cannot maintain the required operating condition and should be investigated electrically.'
),
(
  11,
  'multiple_choice',
  'application',
  'A low-voltage signal becomes unreliable only when routed close to equipment producing strong electrical noise. What fundamental installation issue should be evaluated?',
  '[{"key":"A","text":"Electromagnetic interference, separation, cable type, shielding, and routing"},{"key":"B","text":"Only the device serial number"},{"key":"C","text":"The rack elevation title"},{"key":"D","text":"Whether the cable jacket is the preferred color"}]'::jsonb,
  '["A"]'::jsonb,
  'Signal integrity can be affected by electromagnetic interference, making routing, separation, cable construction, and shielding relevant troubleshooting factors.'
),
(
  12,
  'scenario',
  'scenario',
  'A control processor operates normally until several powered sensors activate simultaneously. The processor then reboots. Voltage at the central supply remains correct, but voltage at the processor drops during the event. What is the BEST next step?',
  '[{"key":"A","text":"Investigate the shared distribution path, conductor resistance, terminations, and load current between the supply and processor"},{"key":"B","text":"Replace the processor without further testing"},{"key":"C","text":"Increase the supply voltage beyond specification"},{"key":"D","text":"Change unrelated programming"}]'::jsonb,
  '["A"]'::jsonb,
  'Correct source voltage combined with low voltage at the load under demand points toward excessive drop or a problem in the distribution path.'
),
(
  13,
  'scenario',
  'scenario',
  'An access-control panel uses a relay to trigger a third-party device. The relay clicks correctly, but the third-party device never activates. Measurement shows no voltage across the device when the relay closes. What should the technician verify?',
  '[{"key":"A","text":"Whether the relay is a dry contact and whether the controlled circuit has the required external power source and correct wiring"},{"key":"B","text":"Whether the relay makes an audible click"},{"key":"C","text":"Whether the panel has an IP address"},{"key":"D","text":"Whether the relay enclosure is grounded to the rack"}]'::jsonb,
  '["A"]'::jsonb,
  'A functioning dry-contact relay still requires a correctly designed external controlled circuit to provide power where needed.'
),
(
  14,
  'scenario',
  'scenario',
  'A distributed low-voltage system has intermittent failures on one wing of a building. All affected devices share the same power-distribution branch, while devices on other branches remain stable. What is the BEST troubleshooting strategy?',
  '[{"key":"A","text":"Test the shared branch under load, including its source, protection, conductor path, terminations, and total connected demand"},{"key":"B","text":"Replace every affected device at once"},{"key":"C","text":"Reconfigure the entire network first"},{"key":"D","text":"Assume multiple independent device failures"}]'::jsonb,
  '["A"]'::jsonb,
  'A symptom shared by devices on one branch strongly suggests evaluating their common electrical path before treating the devices as unrelated failures.'
),
(
  15,
  'scenario',
  'scenario',
  'An analog control signal is stable when equipment is off but becomes noisy whenever a nearby motor drive operates. The cable type is correct, but routing places the signal cable directly beside the noisy equipment conductors. What is the BEST response?',
  '[{"key":"A","text":"Evaluate and correct routing, separation, shielding, grounding, and other interference-control measures specified for the system"},{"key":"B","text":"Increase the control voltage until the noise disappears"},{"key":"C","text":"Replace the controller immediately"},{"key":"D","text":"Ignore the issue because low-voltage signals cannot be affected by nearby electrical equipment"}]'::jsonb,
  '["A"]'::jsonb,
  'Electromagnetic coupling can degrade susceptible low-voltage signals, so installation practices should be evaluated before equipment is condemned.'
),
(
  16,
  'scenario',
  'scenario',
  'A technician replaces a failed central 24 VDC supply with another 24 VDC model. Soon afterward, devices fail whenever the system is heavily loaded. The replacement supply has substantially less wattage capacity than the original. What is the BEST conclusion?',
  '[{"key":"A","text":"Matching voltage alone was insufficient; the replacement supply may not have adequate current and power capacity for the connected load"},{"key":"B","text":"All 24 VDC supplies are electrically interchangeable"},{"key":"C","text":"The devices need higher voltage"},{"key":"D","text":"Power capacity is unrelated to load"}]'::jsonb,
  '["A"]'::jsonb,
  'A replacement power supply must meet voltage, current, power, environmental, and manufacturer requirements for the actual connected system.'
),
(
  17,
  'scenario',
  'scenario',
  'A dry-contact output is connected to a building interface. The building system expects only a contact closure, but 24 VDC from the control rack has been wired through the interface terminals. What is the BEST action?',
  '[{"key":"A","text":"Stop and verify both interface specifications, then rewire so the receiving input is used exactly as designed"},{"key":"B","text":"Leave it because any relay interface can accept external voltage"},{"key":"C","text":"Increase the voltage to improve reliability"},{"key":"D","text":"Add a larger fuse without changing the circuit"}]'::jsonb,
  '["A"]'::jsonb,
  'Interfacing systems requires confirming whether terminals expect dry contacts, powered inputs, reference connections, or another specific electrical condition.'
),
(
  18,
  'scenario',
  'scenario',
  'A technician finds that a shield drain conductor is connected to different reference points throughout a long installation, contrary to the approved system detail. The system has intermittent noise complaints. What is the BEST response?',
  '[{"key":"A","text":"Restore the documented shielding and bonding method and then retest system performance"},{"key":"B","text":"Connect the shield to every metal object nearby"},{"key":"C","text":"Remove the signal conductors and use the shield as the signal path"},{"key":"D","text":"Increase device supply voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Inconsistent shield termination can defeat the intended interference-control strategy and should be corrected to the approved design.'
),
(
  19,
  'scenario',
  'scenario',
  'A low-voltage controller intermittently reports a digital input as active even when the field switch is open. Field wiring inspection reveals moisture and damaged insulation at the remote termination. What is the BEST technical interpretation?',
  '[{"key":"A","text":"Leakage or unintended continuity at the damaged termination may be creating a false input condition"},{"key":"B","text":"An open switch always forces an input active"},{"key":"C","text":"The controller must have failed because field wiring cannot affect input state"},{"key":"D","text":"The system requires more supply voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Damaged or contaminated field wiring can create unintended conductive paths and false low-voltage input states.'
),
(
  20,
  'scenario',
  'scenario',
  'A service technician is diagnosing several symptoms across an integrated system: intermittent device resets, noisy analog control, and one failed relay interface. What is the BEST Level 3 approach?',
  '[{"key":"A","text":"Separate the symptoms into power, signal, and control paths; verify expected electrical conditions at each stage; and correct confirmed faults systematically"},{"key":"B","text":"Replace the main processor because multiple symptoms exist"},{"key":"C","text":"Change programming until all symptoms stop"},{"key":"D","text":"Treat every symptom as unrelated and replace devices one at a time"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 3 troubleshooting applies low-voltage fundamentals systematically across power, signal, and control paths instead of relying on assumptions or broad replacement.'
);

create temporary table _seed_ci_low_voltage_fundamentals_l4_questions (
  question_number integer primary key,
  question_type text not null,
  difficulty text not null,
  prompt text not null,
  options jsonb not null,
  correct_answer jsonb not null,
  rationale text not null
);

insert into _seed_ci_low_voltage_fundamentals_l4_questions (
  question_number, question_type, difficulty, prompt, options, correct_answer, rationale
) values
(
  1,
  'multiple_choice',
  'foundational',
  'Which statement BEST describes Level 4 performance in Low-Voltage Fundamentals?',
  '[{"key":"A","text":"Recognizing basic voltage labels"},{"key":"B","text":"Applying advanced electrical and signal-path judgment across complex systems, identifying systemic risk, and guiding technical standards"},{"key":"C","text":"Replacing failed devices quickly"},{"key":"D","text":"Following installation instructions only"}]'::jsonb,
  '["B"]'::jsonb,
  'Level 4 performance includes advanced technical judgment, system-wide reasoning, and leadership in applying low-voltage fundamentals.'
),
(
  2,
  'multiple_choice',
  'foundational',
  'Why can grounding and bonding strategy matter in complex integrated systems?',
  '[{"key":"A","text":"Because unintended reference differences and current paths can contribute to noise, communication problems, or equipment issues"},{"key":"B","text":"Because grounding increases network bandwidth"},{"key":"C","text":"Because bonding replaces overcurrent protection"},{"key":"D","text":"Because every shield must connect to every metal surface"}]'::jsonb,
  '["A"]'::jsonb,
  'Grounding, bonding, and reference strategy can affect signal integrity and equipment behavior when multiple systems and power sources interact.'
),
(
  3,
  'multiple_choice',
  'foundational',
  'What is the BEST reason to document expected voltages, current demands, signal references, and interface types during system design?',
  '[{"key":"A","text":"To create clear technical criteria for installation, commissioning, troubleshooting, and future service"},{"key":"B","text":"To eliminate all field verification"},{"key":"C","text":"To make equipment labels shorter"},{"key":"D","text":"To avoid using manufacturer documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Documented electrical and interface expectations create a reliable technical baseline for the full system lifecycle.'
),
(
  4,
  'multiple_choice',
  'application',
  'A large integrated system uses multiple DC supplies with interconnected control references. What should a lead technician verify before tying reference conductors together?',
  '[{"key":"A","text":"That the manufacturer and system design permit the connection and that unintended current paths or reference conflicts will not be created"},{"key":"B","text":"That all supplies have the same enclosure color"},{"key":"C","text":"That every supply is physically in the same rack"},{"key":"D","text":"That the network uses static addresses"}]'::jsonb,
  '["A"]'::jsonb,
  'Interconnecting references between separate supplies should be deliberate and based on the system design and equipment requirements.'
),
(
  5,
  'multiple_choice',
  'application',
  'A recurring field issue shows that installers frequently select power supplies based only on voltage rating. What is the BEST Level 4 corrective action?',
  '[{"key":"A","text":"Establish a standard that requires verification of voltage, current, wattage, polarity, load margin, environment, and manufacturer requirements"},{"key":"B","text":"Tell technicians to use larger supplies whenever possible"},{"key":"C","text":"Require only connector matching"},{"key":"D","text":"Allow each technician to choose independently"}]'::jsonb,
  '["A"]'::jsonb,
  'A Level 4 response addresses the recurring technical process, not just the individual installation.'
),
(
  6,
  'multiple_choice',
  'application',
  'A system has intermittent analog noise across several rooms supplied from different field devices but sharing one central reference path. What should the lead investigate?',
  '[{"key":"A","text":"The common reference, grounding, shielding, routing, and upstream system architecture"},{"key":"B","text":"Each room display resolution"},{"key":"C","text":"Only the last device installed"},{"key":"D","text":"Whether the rack labels are alphabetical"}]'::jsonb,
  '["A"]'::jsonb,
  'A symptom spanning multiple areas often points to a shared reference or architecture issue rather than isolated device failures.'
),
(
  7,
  'multiple_choice',
  'application',
  'A project team proposes combining several low-voltage power branches onto one larger supply. What is the BEST technical review?',
  '[{"key":"A","text":"Evaluate total load, branch protection, voltage drop, conductor sizing, fault isolation, redundancy, and service impact"},{"key":"B","text":"Approve it if the supply voltage matches"},{"key":"C","text":"Ignore branch protection because the system is low voltage"},{"key":"D","text":"Use the smallest conductors available"}]'::jsonb,
  '["A"]'::jsonb,
  'Consolidating power distribution changes load, fault, service, and reliability characteristics and should be reviewed as a system decision.'
),
(
  8,
  'multiple_choice',
  'application',
  'A commissioning team repeatedly finds undocumented field changes to low-voltage power and control wiring. What is the BEST response?',
  '[{"key":"A","text":"Verify the actual installation, reconcile it with the approved design, and update controlled documentation"},{"key":"B","text":"Keep separate handwritten notes indefinitely"},{"key":"C","text":"Ignore changes if the system currently works"},{"key":"D","text":"Remove all documentation"}]'::jsonb,
  '["A"]'::jsonb,
  'Accurate controlled documentation is essential for commissioning, troubleshooting, maintenance, and future modifications.'
),
(
  9,
  'multiple_choice',
  'application',
  'A senior technician sees a design using one unprotected central power output to feed many critical devices. What concern should be raised?',
  '[{"key":"A","text":"A single branch fault may disrupt a large portion of the system and complicate fault isolation"},{"key":"B","text":"The devices will automatically increase network traffic"},{"key":"C","text":"The voltage will always double"},{"key":"D","text":"The system cannot use DC power"}]'::jsonb,
  '["A"]'::jsonb,
  'Distribution architecture affects fault containment, serviceability, and system resilience.'
),
(
  10,
  'multiple_choice',
  'application',
  'A recurring device-reset problem appears only during peak system operation. Basic unloaded voltage tests are normal. What should the senior technician require?',
  '[{"key":"A","text":"Loaded measurements and review of supply capacity, voltage drop, transient demand, shared connections, and distribution design"},{"key":"B","text":"Only another unloaded voltage measurement"},{"key":"C","text":"Replacement of every affected device"},{"key":"D","text":"Higher-than-rated supply voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Intermittent failures tied to operating demand require testing under actual load conditions and reviewing the complete distribution path.'
),
(
  11,
  'scenario',
  'scenario',
  'A campus-wide integrated system has random controller resets in several buildings. Each affected controller uses the same model power supply, and logged measurements show voltage sag during startup events. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Quantify startup demand, verify supply and distribution capacity, determine whether the issue is systemic, and implement a documented corrective standard across affected sites"},{"key":"B","text":"Replace one controller and close the issue"},{"key":"C","text":"Increase voltage beyond specification at every site"},{"key":"D","text":"Treat each reset as unrelated"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 work identifies whether recurring failures share a common design cause and corrects the system standard rather than only individual symptoms.'
),
(
  12,
  'scenario',
  'scenario',
  'A project interfaces security, lighting, and AV systems through several relay and control connections. During commissioning, different teams have assumed different meanings for dry contact, powered input, and common reference. What is the BEST lead response?',
  '[{"key":"A","text":"Stop interface commissioning, reconcile each interface against manufacturer documentation, define the electrical behavior clearly, and update the coordinated drawings"},{"key":"B","text":"Allow each team to wire according to its own convention"},{"key":"C","text":"Apply 24 VDC to every control input"},{"key":"D","text":"Replace all relays"}]'::jsonb,
  '["A"]'::jsonb,
  'Cross-system interfaces require a shared, documented understanding of the exact electrical behavior at each connection.'
),
(
  13,
  'scenario',
  'scenario',
  'A lead technician discovers that field crews routinely parallel spare conductors to reduce voltage drop without documentation or engineering review. What is the BEST response?',
  '[{"key":"A","text":"Stop the informal practice, verify the electrical design, establish an approved conductor-sizing method, and correct documentation where needed"},{"key":"B","text":"Continue because more copper always solves the problem"},{"key":"C","text":"Use spare conductors on every circuit"},{"key":"D","text":"Increase fuse sizes to match the extra conductors"}]'::jsonb,
  '["A"]'::jsonb,
  'Uncontrolled field modifications can create inconsistent, poorly documented systems; recurring design issues should be corrected through an approved standard.'
),
(
  14,
  'scenario',
  'scenario',
  'A complex control system works correctly until a new third-party subsystem is connected. Afterward, analog signals become unstable and communication faults appear. What is the BEST Level 4 troubleshooting approach?',
  '[{"key":"A","text":"Evaluate the new interface for reference conflicts, grounding or bonding paths, shielding, electrical compatibility, and common-mode issues before replacing unrelated devices"},{"key":"B","text":"Replace the central controller immediately"},{"key":"C","text":"Increase every signal voltage"},{"key":"D","text":"Disconnect all protective grounds"}]'::jsonb,
  '["A"]'::jsonb,
  'A new interconnected subsystem can change electrical references and interference paths, so the interface architecture should be examined first.'
),
(
  15,
  'scenario',
  'scenario',
  'A facility reports repeated failures of one model of low-voltage device across multiple projects. Investigation shows the devices are routinely powered from supplies near the maximum allowable cable distance and load. What is the BEST response?',
  '[{"key":"A","text":"Review the design standard for voltage drop, supply margin, conductor size, and installation distance, then correct the recurring design condition"},{"key":"B","text":"Continue replacing failed devices"},{"key":"C","text":"Raise supply voltage above the manufacturer rating"},{"key":"D","text":"Ignore cable distance because the systems are low voltage"}]'::jsonb,
  '["A"]'::jsonb,
  'Repeated failures across projects suggest a design or implementation pattern that should be corrected at the standard level.'
),
(
  16,
  'scenario',
  'scenario',
  'A central low-voltage supply powers access, control, and monitoring devices. One shorted field branch repeatedly shuts down the entire system. What is the BEST Level 4 improvement?',
  '[{"key":"A","text":"Redesign or revise distribution to provide appropriate branch protection and fault isolation while meeting system requirements"},{"key":"B","text":"Install a larger fuse at the central supply only"},{"key":"C","text":"Increase supply voltage"},{"key":"D","text":"Remove overcurrent protection"}]'::jsonb,
  '["A"]'::jsonb,
  'Fault isolation and appropriate branch protection can prevent one field fault from disabling unrelated critical loads.'
),
(
  17,
  'scenario',
  'scenario',
  'A senior technician reviewing a service history sees repeated intermittent faults caused by undocumented polarity reversals and inconsistent conductor identification. What is the BEST response?',
  '[{"key":"A","text":"Establish and enforce a consistent conductor-identification and polarity standard, correct documentation, and address existing nonconforming work"},{"key":"B","text":"Tell technicians to remember which colors were used on each project"},{"key":"C","text":"Ignore polarity if devices appear to work"},{"key":"D","text":"Require different colors on every project"}]'::jsonb,
  '["A"]'::jsonb,
  'A recurring field problem calls for a consistent technical standard and controlled documentation rather than reliance on individual memory.'
),
(
  18,
  'scenario',
  'scenario',
  'During commissioning, several remote devices pass functional tests individually but fail when the entire system operates simultaneously. What is the BEST Level 4 next step?',
  '[{"key":"A","text":"Test the complete system under realistic simultaneous load and evaluate shared power, reference, signal, and distribution constraints"},{"key":"B","text":"Accept the individual tests as proof the system is complete"},{"key":"C","text":"Replace all remote devices"},{"key":"D","text":"Disable half the system permanently"}]'::jsonb,
  '["A"]'::jsonb,
  'System-level commissioning must verify behavior under realistic combined operating conditions, not only isolated device operation.'
),
(
  19,
  'scenario',
  'scenario',
  'A design team wants to standardize one power supply for many device types to simplify purchasing. What is the BEST senior technical response?',
  '[{"key":"A","text":"Standardize only where voltage, current, power, polarity, connector, environmental, protection, and manufacturer requirements are genuinely compatible"},{"key":"B","text":"Approve one supply if its voltage matches most devices"},{"key":"C","text":"Use the highest-voltage supply for everything"},{"key":"D","text":"Ignore current ratings because devices draw only what they need"}]'::jsonb,
  '["A"]'::jsonb,
  'Standardization is valuable only when the selected equipment remains technically compatible with every intended application.'
),
(
  20,
  'scenario',
  'scenario',
  'A company has recurring service calls involving power, grounding, relay interfaces, and signal-reference mistakes across different technicians and projects. What is the BEST Level 4 response?',
  '[{"key":"A","text":"Use the failure data to strengthen design standards, installation documentation, technician training, commissioning checks, and quality-control requirements"},{"key":"B","text":"Handle each service call independently and make no process changes"},{"key":"C","text":"Replace more equipment during installation"},{"key":"D","text":"Reduce documentation so technicians work faster"}]'::jsonb,
  '["A"]'::jsonb,
  'Level 4 technical leadership converts recurring field failures into improved standards, training, documentation, and quality controls.'
);


do $$
declare
  v_industry_id uuid;
  v_competency_id uuid := '36c2f7c4-ec0b-409b-b8f4-76a3905ac28f';
  v_l1_role_id uuid := '006a91b3-38dc-4d13-9532-f22d839af945';
  v_l2_role_id uuid := '8afaef4d-439a-468f-8998-f6abc1413b76';
  v_l3_role_id uuid := '2aaf62ec-fe33-48bc-a4eb-f8ace558a06f';
  v_l4_role_id uuid := '34509f61-b041-4323-b927-cc8639bac9b4';
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
      and c.name = 'Low-Voltage Fundamentals'
      and c.is_current = true
  ) then
    raise exception 'Current Low-Voltage Fundamentals Master Competency not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l1_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Logistics Manager'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 1
  ) then
    raise exception 'Current Logistics Manager L1 Low-Voltage Fundamentals requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l2_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Operations Manager'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 2
  ) then
    raise exception 'Current Operations Manager L2 Low-Voltage Fundamentals requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l3_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Systems Designer'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 3
  ) then
    raise exception 'Current Systems Designer L3 Low-Voltage Fundamentals requirement not found';
  end if;

  if not exists (
    select 1
    from public.master_role_templates r
    join public.master_role_competency_requirements mrcr
      on mrcr.master_role_template_id = r.id
    where r.id = v_l4_role_id
      and r.industry_id = v_industry_id
      and r.name = 'Service Technician'
      and r.is_current = true
      and mrcr.master_competency_template_id = v_competency_id
      and mrcr.required_level = 4
  ) then
    raise exception 'Current Service Technician L4 Low-Voltage Fundamentals requirement not found';
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
  v_assessment_name := 'Low-Voltage Fundamentals — Level 1 Competency Assessment';

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
    select * from _seed_ci_low_voltage_fundamentals_l1_questions
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
        'Low-Voltage Fundamentals',
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
      'IntegrateU Low-Voltage Fundamentals L1 production assessment v1.0.',
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
        'Low-Voltage Fundamentals',
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
        'IntegrateU Low-Voltage Fundamentals L1 production assessment v1.0.',
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
  v_assessment_name := 'Low-Voltage Fundamentals — Level 2 Competency Assessment';

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
    select * from _seed_ci_low_voltage_fundamentals_l2_questions
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
        'Low-Voltage Fundamentals',
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
      'IntegrateU Low-Voltage Fundamentals L2 production assessment v1.0.',
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
        'Low-Voltage Fundamentals',
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
        'IntegrateU Low-Voltage Fundamentals L2 production assessment v1.0.',
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
  v_assessment_name := 'Low-Voltage Fundamentals — Level 3 Competency Assessment';

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
    select * from _seed_ci_low_voltage_fundamentals_l3_questions
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
        'Low-Voltage Fundamentals',
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
      'IntegrateU Low-Voltage Fundamentals L3 production assessment v1.0.',
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
        'Low-Voltage Fundamentals',
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
        'IntegrateU Low-Voltage Fundamentals L3 production assessment v1.0.',
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
  v_assessment_name := 'Low-Voltage Fundamentals — Level 4 Competency Assessment';

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
    select * from _seed_ci_low_voltage_fundamentals_l4_questions
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
        'Low-Voltage Fundamentals',
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
      'IntegrateU Low-Voltage Fundamentals L4 production assessment v1.0.',
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
        'Low-Voltage Fundamentals',
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
        'IntegrateU Low-Voltage Fundamentals L4 production assessment v1.0.',
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
